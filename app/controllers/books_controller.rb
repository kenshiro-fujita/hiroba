class BooksController < ApplicationController
  before_action :require_user_logged_in, only: [:create]
  before_action :set_search, only: [:index]

  def index
    @search = Book.ransack(params[:q])
    @books = @search.result.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user

    if logged_in?
      @review = current_user.reviews.build
      @user_review = Review.where(user_id: @user, book_id: @book).first # 条件分岐用
    end
  end

  def new
    @book = Book.new  #投稿フォーム用空インスタンス
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:success] = '本を登録しました'
      redirect_to @book
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :new
    end
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :publisher, :release_date)
  end

  def set_search
    @search = Book.ransack(params[:q])
    @books = @search.result
  end
end
