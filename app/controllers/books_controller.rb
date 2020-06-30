class BooksController < ApplicationController
  def index
    @all_books = Book.order(id: :desc).page(params[:page]).per(30)
  end

  def show
    @book = Book.find(params[:id]) #bookに紐づいたreviewは book.reviewsで取得できる。
    @review = current_user.reviews.build #投稿フォーム用の空インスタンス
  end

  def new
    @book = Book.new　#book投稿用の空インスタンス
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
  
end