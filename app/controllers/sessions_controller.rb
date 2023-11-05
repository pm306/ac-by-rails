class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to index_path #TODO:実装
    else
      flash.now[:danger] = "無効なメールアドレスかパスワードです"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:session] = "ログアウトしました。"
    redirect_to login_url
  end

end
