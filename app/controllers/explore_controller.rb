class ExploreController < ApplicationController
  def home
    @posts = Post.all
  end
end
