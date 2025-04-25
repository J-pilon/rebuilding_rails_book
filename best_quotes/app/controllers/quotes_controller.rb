class QuotesController < Rulers::Controller
  def show
    ua = request.user_agent
    q = Quote.find(id)
    render(:show, :obj => q, :ua => ua)
  end

  def index
    quotes = Quote.all
    render(:index, :quotes => quotes)
  end

  def new
    render(:new)
  end

  def create
    if request.post?
      data = request.POST

      begin
        q = Quote.create(data)
        render(:show, :obj => q)
      rescue => e
        puts "Error: #{e}"
      end
    else
      quotes = Quote.all
      render(:index, :quotes => quotes)
    end
  end

  def edit
    q = Quote.find(id)
    render(:edit, :obj => q)
  end

  def update
    if request.post?
      data = request.POST

      begin
        f = Quote.find(id)
        q = f.update(data)
        render(:show, :obj => q)
      rescue => e
        puts "Error: #{e}"
      end
    else
      quotes = Quote.all
      render(:index, :quotes => quotes)
    end
  end

  def destroy
    if request.post?
      begin
        raise "Parameter id is #{id}" if id == nil

        if Quote.delete(id)
          puts "FILE DELETED"
        end

        quotes = Quote.all
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
