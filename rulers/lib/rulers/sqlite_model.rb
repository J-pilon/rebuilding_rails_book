require "sqlite3"
require "rulers/util"

DB = SQLite3::Database.new "test.db"

module Rulers
  module Model
    class SQLite
      attr_reader :hash

      def initialize(data = nil)
        @hash = data
      end

      def method_missing(name, *args)
        self.class.schema.keys.each do |column_name|
          if column_name == name.to_s
            self.class.define_method(name) do
              self[column_name]
            end

            return self.send(name)
          end
        end

        raise "Error: method #{name} doesn't match any column names on #{self.class.table}"
      end

      def to_ary
        nil
      end

      def save!
        fields = @hash.map do |k, v|
          "#{k}=#{self.class.to_sql(v)}"
        end.join(",")

        DB.execute <<~SQL
          UPDATE #{self.class.table}
          SET #{fields}
          WHERE id = #{@hash["id"]}
        SQL
        true
      end

      def save
        self.save! rescue false
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, val)
        @hash[name.to_s] = val
      end

      def self.table
        Rulers.to_underscore name
        if name[-1] != "s"
          pluralized_name = name + "s"
          return pluralized_name
        end

        return name
      end

      def self.schema
        return @schema if @schema # instance variable on the class itself not an instance of the class

        @schema = {}
        DB.table_info(table) do |row|
          @schema[row["name"]] = row["type"]
        end
        @schema
      end

      def self.to_sql(val)
        case val
        when NilClass
          "null"
        when Numeric
          val.to_s
        when String
          "\"#{val}\""
        else
          raise "Can't change #{val.class} to SQL!"
        end
      end

      def self.find(id)
        puts "id: #{id}"
        puts "table: #{table}"
        puts "schema: #{schema.keys.join(",")}"
        row = DB.execute <<~SQL
          select #{schema.keys.join(",")} from #{table} where id = #{id};
        SQL

        data = Hash[schema.keys.zip row[0]]
        puts "data: #{data}"
        self.new data
      end

      def self.create(values)
        values.delete "id"
        keys = schema.keys - ["id"]
        vals = keys.map do |key|
          values[key] ? to_sql(values[key]) : "null"
        end

        DB.execute <<~SQL
          INSERT INTO #{table} (#{keys.join(",")})
          VALUES (#{vals.join(",")});
        SQL

        raw_vals = keys.map { |k| values[k] }
        data = Hash[keys.zip raw_vals]
        sql = "SELECT last_insert_rowid();"
        data["id"] = DB.execute(sql)[0][0]
        self.new data
      end

      def self.count
        DB.execute(<<~SQL)[0][0]
          SELECT COUNT(*) FROM #{table};
        SQL
      end

      def self.all
        records = DB.execute(<<~SQL)
          SELECT * FROM #{table};
        SQL

        new_records = records.map do |record|
          data = Hash[schema.keys.zip record]
          self.new data
        end

        return new_records
      end
    end
  end
end
