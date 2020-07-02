class ReviewsController < ApplicationController
    before_action :require_user_logged_in, only: [:new, :edit, :destroy]
    before_action :correct_user, only: [:new, :edit, :destroy]

  def index
  end
  
  def show
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    @user = User.find(@review.user_id)
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.book_id = params[:book_id].to_i #ネスト構造にしたらこれで取得できた。hidden_field は意味無し。

    if @review.save
      flash[:success] = '書評を投稿しました'
      redirect_to book_review_path(@review.book_id, @review.id)
    else
      flash[:danger] = '書評の投稿に失敗しました'
      redirect_to book_path(@review.book_id)
    end
  end

  def edit
    @review = Review.find(params[:id])
    @book = Book.find(params[:book_id])
  end

  def update
    @review = Review.find(params[:id])
    @book = Book.find(@review.book_id)
    @review.update(params.require(:review).permit(:content, :rev_title))
    
    if @review.save
      flash[:success] = '書評を更新しました'
      redirect_to book_review_path(@book, @review)
    else
      flash.now[:danger] = '書評の更新に失敗しました'
      render :edit
    end
  end
  #成功後は review → show に戻るようにする。

  def destroy
    @book = Book.find(@review.book_id)
    @review.destroy
    flash[:success] = "書評を削除しました"
    redirect_to book_path(@book)
  end
  #成功後は当該bookのページに戻るようにしたい。
  
  private
  
  def review_params
    params.require(:review).permit(:content, :rev_title)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id]) #current_userはsession helperで定義。
    unless @review
      redirect_to root_url
    end
  end
  
  
end
