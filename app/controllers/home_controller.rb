class HomeController < ApplicationController
  def index
    if current_user != nil
      redirect_to explore_home_path
    end
  end
end
