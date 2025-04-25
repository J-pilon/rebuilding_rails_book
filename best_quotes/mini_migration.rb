require "sqlite3"

conn = SQLite3::Database.new "test.db"

conn.execute <<SQL
create table quotes(
  id INTEGER PRIMARY KEY,
  submitter VARCHAR(30),
  quote VARCHAR(32000),
  attribution VARCHAR(30));
SQL
