class ToppagesController < ApplicationController
  def index
    @reviews = Review.all.order(id: :desc) #トップページ表示用
  end
end
