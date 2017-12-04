class ExploreController < ApplicationController
  def home
    @posts = nil
    if(current_user.secret)
      @posts = Post.all
    else
      @posts = Post.where(private: false)
    end
  end

  def profile
    @posts = Post.where(owner: current_user.username)
  end
end
