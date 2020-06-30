class ToppagesController < ApplicationController
  def index
    @all_review = Review.all.order(id: :desc) #トップページ表示用
  end
end
