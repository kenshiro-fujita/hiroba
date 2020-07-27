class RecommendationsController < ApplicationController
  before_action :require_user_logged_in

  def create
    good_book = Book.find(params[:book_id])
    current_user.recommend(good_book)
    flash[:success] = 'この本をオススメに追加しました'
    redirect_back(fallback_location: root_url)
  end

  def destroy
    no_good_book = Book.find(params[:book_id])
    current_user.unrecommend(no_good_book)
    flash[:danger] = 'この本のオススメを解除しました'
    redirect_back(fallback_location: root_url)
  end
end
