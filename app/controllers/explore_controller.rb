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
    @last_id = ''
    @m.sort_by {|x| [x.convo_id, x.created_at] }.reverse.each_with_index do |mes, i|
      if i == 0 || @last_id != mes.convo_id
        @latest.push(mes)
        @last_id = mes.convo_id
      end
    end

  end
end
