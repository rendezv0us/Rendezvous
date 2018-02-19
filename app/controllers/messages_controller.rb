class MessagesController < ApplicationController
  def index
  end

  def new
    @m = Message.new()
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

  end

  def create
    @m = Message.new(post_params)
    if current_user
      @m.sender = current_user.username
    else
      return
    end

    respond_to do |format|
      if @m.save
        format.html { redirect_to @m, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @m }
      else
        format.html { render :new }
        format.json { render json: @m.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_m
      @m = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:message).permit(:sender, :receiver, :content)
    end

end
