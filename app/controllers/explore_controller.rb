class ExploreController < ApplicationController
  def home
    if current_user.secret
      redirect_to messages_new_path
    end

    @posts = Post.where(private: false).order("created_at DESC").first(25)
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

  def search
    @search_word = params[:search_word]
    @post_matches = Post.where("title like ? OR owner=?", "%#{@search_word}%", @search_word)
    @user_matches = User.where("username like ?", "#{@search_word}%")
  end
end
