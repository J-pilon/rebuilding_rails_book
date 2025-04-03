class QuotesController < Rulers::Controller
  def index
    quotes = FileModel.all
    render(:index, :quotes => quotes)
  end

  def a_quote
    render(:a_quote, :noun => :winking)
  end

  def quote_1
    quote_1 = FileModel.find(1)
    render(:quote, :obj => quote_1)
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

  def edit_quote
    quote = FileModel.find(id)

    puts quote.hash
    render(:edit, :obj => quote)
  end

  def update_quote
    if request.post?
      data = request.POST

      begin
        f = FileModel.find(id)
        quote = f.update(data)
        render(:quote, :obj => quote)
      rescue => e
        puts "Error: #{e}"
      end
    else
      quotes = FileModel.all
      render(:index, :quotes => quotes)
    end
  end

  def destroy
    raise "Error: parameter id is #{id}" if id == nil

    if FileModel.delete(id)
      puts "FILE DELETED"
    end

    render(:index, :quotes => quotes)
  rescue => e
    puts "Error: #{e}"
    ""
  end

  def exception
    raise "Its a bad one!"
  end

  private

  def id
    params["id"]
  end
end
