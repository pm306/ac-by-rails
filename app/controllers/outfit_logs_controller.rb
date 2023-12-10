class OutfitLogsController < ApplicationController
  before_action :require_login, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, with: :log_not_found

  def index
    @outfit_logs = OutfitLog.includes(:clothes).where(user_id: current_user.id)
  end

  private

  def log_not_found
    redirect_with_alert(I18n.t('flash.outfit_logs.not_found'), root_url)
  end
end
