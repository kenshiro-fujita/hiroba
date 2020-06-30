module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    #@current_user変数は他のところからは代入されない。ということでnilになっていれば現在のログインユーザーを代入する。
    #代入されていたとすればこのメソッドで代入するしかないので、現在のログインユーザーであるとわかる。
  end
  
  def logged_in?
    !!current_user
  end
    
end
