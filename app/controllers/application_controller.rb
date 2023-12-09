class ApplicationController < ActionController::Base
  include SessionsHelper

  def redirect_with_alert(message, path)
    flash[:alert] = message
    redirect_to path
  end

  def redirect_with_notice(message, path)
    flash[:notice] = message
    redirect_to path
  end

  def render_with_alert(message, action)
    flash.now[:alert] = message
    render action
  end

  def render_with_notice(message, action)
    flash.now[:notice] = message
    render action
  end
end
