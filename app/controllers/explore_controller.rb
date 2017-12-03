class ExploreController < ApplicationController
  def home
    @posts = nil
    if(current_user.secret)
      @posts = Post.all
    else
      @posts = Post.where(private: false)
    end
  end
end
