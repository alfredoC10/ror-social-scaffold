class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:error] = 'Post was destroyed!'
  end

  private

  def timeline_posts
    list = current_user.friendships.map { |freund| freund.friend.id if freund.confirmed == true }
    list += current_user.inverse_friendships.map { |freund| freund.user.id if freund.confirmed == true }
    list += [current_user.id]
    @timeline_posts ||= Post.where('user_id IN (?)', list).ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
