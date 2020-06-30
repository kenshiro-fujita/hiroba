class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:edit, :update, :destroy]

  def index
  end

  def show
    @user = User.find(params[:id])
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
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  

end
