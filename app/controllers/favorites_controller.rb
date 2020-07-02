class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    good_rev = Review.find(params[:review_id])
    current_user.great(good_rev)
    flash[:success] = 'この書評をお気に入りに追加しました'
    redirect_back(fallback_location: root_url)
  end

  def destroy
    no_good_rev = Review.find(params[:review_id])
    current_user.ungreat(no_good_rev)
    flash[:danger] = '書評のお気に入りを解除しました'
    redirect_back(fallback_location: root_url)
  end
end
