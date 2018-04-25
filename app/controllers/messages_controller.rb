class MessagesController < ApplicationController

  def index
  end

  def new
    @m = Message.new
    @alert = session[:message_alert]
    session[:message_alert] = nil
  end

  def check
    render json: {size: Message.where(convo_id: params[:convo]).size}
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @new_m = Message.new
    @m = Message.find(params[:id])
    @recipient = if @m.receiver != current_user.username
                   @m.receiver
                 else
                   @m.sender
                 end

    if  @m.convo_id != gen_convo_id(@m.sender, current_user.username) &&
        @m.convo_id != gen_convo_id(current_user.username, @m.receiver)
      redirect_to home_index_path
    end
    @all = Message.where(convo_id: gen_convo_id(@m.sender, @m.receiver))
    @all = @all.sort_by(&:created_at)
  end

  def update

    create
  end

  def create
    @m = Message.new(post_params)
    if User.where(username: @m.receiver).empty?
      session[:message_alert] = 'Could not find user with username: "' + @m.receiver + '"'
      redirect_to messages_new_path
      return
    elsif current_user
      @m.sender = current_user.username
    else
      return
    end

    if @m.content == "" || @m.receiver == ""
      return
    end

    @m.convo_id = gen_convo_id(@m.sender, @m.receiver)

    respond_to do |format|
      if @m.save
        format.html { redirect_to @m, notice: 'Message was successfully sent.' }
        format.json { render :show, status: :created, location: @m }
      else
        format.html { render :new }
        format.json { render json: @m.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def delete_convo
    @receiver = params[:receiver]
    @convo_id = gen_convo_id(current_user.username, @receiver)
    Message.where(:convo_id => @convo_id).destroy_all
    redirect_to messages_new_path
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

  def gen_convo_id(sender, receiver)
    @key = ''
    if sender > receiver
      @key = "#{receiver}_#{sender}"
    else
      @key = "#{sender}_#{receiver}"
    end
    return @key
  end
end
