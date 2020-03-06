class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザー登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end      

  
  def destroy
  end
  #成功後はトップページに戻るのでview不要

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
