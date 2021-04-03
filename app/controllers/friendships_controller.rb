class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def new
    @friendship = Friendship.new(friendship_params)
  end

  def create
    @friendship = Friendship.create!(friendship_params)

    if @friendship.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attribute(:confirmed, true)
    @friendship_two = Friendship.new(user_id: @friendship.friend_id, friend_id: @friendship.user_id, confirmed: true)
    @friendship_two.save
    flash[:notice] = 'Friendship has been accepted'
    redirect_to users_path
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed, :id)
  end
end
