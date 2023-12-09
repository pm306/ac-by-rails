class OutfitLogsController < ApplicationController
  before_action :require_login, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, with: :log_not_found

  def index
    @outfit_logs = OutfitLog.includes(:clothes).where(user_id: current_user.id)
  end

  private

  def log_not_found
    redirect_to root_url, alart: '服装のログが取得できませんでした。'
  end
end
