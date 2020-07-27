class RelationshipsController < ApplicationController
  before_action :require_user_logged_in

  def create
    followed_user = User.find(params[:follow_id])
    current_user.follow(followed_user)
    flash[:success] = 'ユーザーをフォローしました'
    # redirect_to user_path(followed_user)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    unfollow_user = User.find(params[:follow_id])
    current_user.unfollow(unfollow_user)
    flash[:success] = 'ユーザーのフォローを解除しました'
    # redirect_to user_path(unfollow_user)
    redirect_back(fallback_location: root_url)
  end
end
