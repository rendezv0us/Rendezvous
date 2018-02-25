class ExploreController < ApplicationController
  def home
    @posts = nil
    if current_user.secret
      @posts = Post.where(owner: current_user.username)
    else
      @posts = Post.where(private: false)
    end
  end

  def profile
    @p = Post.where(owner: current_user.username)
    @m = Message.where("Messages.convo_id LIKE ?", "%#{current_user.username}%")

    @latest = []
    @m.sort_by(&:created_at).reverse.each do |mes|
      if @latest.count { |each| each.convo_id == mes.convo_id }.zero?
        @latest.push(mes)
      else
        break
      end
    end

  end
end
