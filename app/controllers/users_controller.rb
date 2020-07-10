class UsersController < ApplicationController
  before_action :correct_user, only:[:edit, :update, :destroy]

  def index
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.my_reviews.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end
  #成功後はshowに遷移させるのでview不要

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    
    if @user.save
      flash[:success] = 'ユーザー情報を更新しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
  end
  #成功後はshowに戻るのでview不要

  def destroy
  end
  #成功後はトップページに戻るのでview不要
  
  def likes
    @user = User.find(params[:id])
    @reviews = @user.likes.page(params[:page])
    counts(@user)
  end
  
  def importants
    @user = User.find(params[:id])
    @books = @user.importants.page(params[:page])
    counts(@user)
  end
  
  def followings
    @user = User.find(params[:id])
    @all_follow = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @all_follower = @user.followers.page(params[:page])
    counts(@user)
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
end
