class QuotesController < Rulers::Controller
  def index
    quotes = FileModel.all
    render(:index, :quotes => quotes)
  end

  def new_quote
    attrs = {
      "submitter" => "Josiah",
      "quote" => "Shake your booty",
      "attribution" => "Josiah"
    }
    m = FileModel.create(attrs)
    render(:quote, :obj => m)
  end

  def a_quote
    render(:a_quote, :noun => :winking)
  end

  def quote_1
    quote_1 = FileModel.find(1)
    render(:quote, :obj => quote_1)
  end

  def destroy
    id = params["id"]

    raise "Error: parameter id is #{id}" if id == nil

    if FileModel.delete(id)
      puts "FILE DELETED"
    end
  rescue => e
    puts "Error: #{e}"
    ""
  end

  def exception
    raise "Its a bad one!"
  end
end
