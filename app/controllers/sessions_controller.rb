class SessionsController < ApplicationController
  before_action :require_no_login, only: [:new, :create]

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
    reset_session
    flash[:notice] = "ログアウトしました。"
    redirect_to login_url
  end

end
