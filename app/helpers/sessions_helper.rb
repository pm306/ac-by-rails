module SessionsHelper

    def log_in(user)
      session[:user_id] = user.id
    end
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    def logged_in?
      !current_user.nil?
    end
  
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def require_no_login
    if logged_in?
      redirect_to root_url
    end
  end
end
