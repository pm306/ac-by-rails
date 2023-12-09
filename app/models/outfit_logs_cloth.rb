# == Schema Information
#
# Table name: outfit_logs_clothes
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cloth_id      :bigint           not null
#  outfit_log_id :bigint           not null
#
# Indexes
#
#  index_outfit_logs_clothes_on_cloth_id       (cloth_id)
#  index_outfit_logs_clothes_on_outfit_log_id  (outfit_log_id)
#
# Foreign Keys
#
#  fk_rails_...  (cloth_id => clothes.id)
#  fk_rails_...  (outfit_log_id => outfit_logs.id)
#
class OutfitLogsCloth < ApplicationRecord
  belongs_to :outfit_log
  belongs_to :cloth
end
