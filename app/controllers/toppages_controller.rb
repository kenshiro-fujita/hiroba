class ToppagesController < ApplicationController
  def index
    @reviews = Review.all.order(id: :desc).page(params[:page]).per(10) # トップページ表示用
  end
end
