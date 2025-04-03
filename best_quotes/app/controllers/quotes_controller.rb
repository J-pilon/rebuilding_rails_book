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

  def new
    render(:new)
  end

  def create
    if request.post?
      data = request.POST

      begin
        quote = FileModel.create(data)
        render(:quote, :obj => quote)
      rescue => e
        puts "Error: #{e}"
      end
    else
      quotes = FileModel.all
      render(:index, :quotes => quotes)
    end
  end

  def edit
    quote = FileModel.find(id)

    puts quote.hash
    render(:edit, :obj => quote)
  end

  def update
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
    if request.post?
      begin
        raise "Parameter id is #{id}" if id == nil

        if FileModel.delete(id)
          puts "FILE DELETED"
        end

        quotes = FileModel.all
        render(:index, :quotes => quotes)
      rescue => e
        puts "Error: #{e}"
        ""
      end
    end
  end

  def exception
    raise "Its a bad one!"
  end

  private

  def id
    params["id"]
  end
end
