module SessionsHelper

    # 渡されたユーザーでログインする
    def log_in(user)
      session[:user_id] = user.id
    end
  
    # 現在ログイン中のユーザーを返す（いる場合）
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
      !current_user.nil?
    end
  
    # 現在のユーザーをログアウトする
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

      # ユーザがログインしていなければログインページにリダイレクト
  def require_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # ユーザがログインしていればホームページにリダイレクト
  def require_no_login
    if logged_in?
      redirect_to root_url
    end
  end
end
