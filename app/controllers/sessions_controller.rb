class SessionsController < ApplicationController
  before_action :require_no_login, only: %i[new create]
  before_action :require_login, only: [:destroy]

  def new; end

  def create
    user = authenticate_user(params[:session][:email], params[:session][:password])
    if user
      log_in user
      redirect_with_notice(I18n.t('flash.sessions.login_success'), root_url)
    else
      render_with_alert(I18n.t('flash.sessions.login_failure'), :new)
    end
  end

  def destroy
    reset_session
    redirect_with_notice(I18n.t('flash.sessions.logout_success'), login_url)
  end

  private

  def authenticate_user(email, password)
    user = User.find_by(email: email.downcase)
    user if user && user.authenticate(password)
  end
end
