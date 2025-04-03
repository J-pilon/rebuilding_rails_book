class QuotesController < Rulers::Controller
  def show
    ua = request.user_agent
    q = FileModel.find(1)
    render_response(:show, :obj => q, :ua => ua)
  end

  def index
    quotes = FileModel.all
    render(:index, :quotes => quotes)
  end

  def new
    render(:new)
  end

  def create
    if request.post?
      data = request.POST

      begin
        q = FileModel.create(data)
        render(:quote, :obj => q)
      rescue => e
        puts "Error: #{e}"
      end
    else
      quotes = FileModel.all
      render(:index, :quotes => quotes)
    end
  end

  def edit
    q = FileModel.find(id)
    render(:edit, :obj => q)
  end

  def update
    if request.post?
      data = request.POST

      begin
        f = FileModel.find(id)
        q = f.update(data)
        render(:show, :obj => q)
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
