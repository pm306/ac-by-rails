class OutfitLog < ApplicationRecord
  belongs_to :user
  has_many :outfit_logs_clothes
  has_many :cloths, through: :outfit_logs_clothes  
end
