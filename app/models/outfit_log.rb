# == Schema Information
#
# Table name: outfit_logs
#
#  id         :bigint           not null, primary key
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_outfit_logs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class OutfitLog < ApplicationRecord
  belongs_to :user
  has_many :outfit_logs_clothes
  has_many :clothes, through: :outfit_logs_clothes
end
