class OutfitLog < ApplicationRecord
  belongs_to :user
  has_many :outfit_logs_clothes
  has_many :clothes, through: :outfit_logs_clothes  
end
