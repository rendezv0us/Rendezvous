class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    redirect_to explore_home_url
  end

  def populate
    for i in 0...10 do
      @post = Post.new
      @r = Random.new
      @post.owner = LiterateRandomizer.word + LiterateRandomizer.word + @r.rand(100).to_s
      @post.title = LiterateRandomizer.sentence
      @post.body = LiterateRandomizer.paragraph
      @post.private = false
      @post.save
    end

    return index
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if !current_user.secret && Post.find(params[:id]).private
      redirect_to explore_home_url
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
    if current_user == nil
      redirect_to explore_home_url
    elsif current_user.secret
      redirect_to explore_profile_url
    end
  end

  # GET /posts/1/edit
  def edit
    if current_user == nil || Post.find(params[:id]).owner != current_user.username
      redirect_to explore_home_url
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    if current_user
      @post.owner = current_user.username
      @post.private = current_user.secret
    else
      return
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:owner, :title, :body, :coordinate, :private)
    end
end