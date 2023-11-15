class SessionsController < ApplicationController
  before_action :require_no_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "ログインに成功しました"
      log_in user
      redirect_to root_url
    else
      flash[:error] = "無効なメールアドレスかパスワードです"
      render :new
    end
  end

  def destroy
    reset_session
    flash[:notice] = "ログアウトしました"
    redirect_to login_url
  end

end
