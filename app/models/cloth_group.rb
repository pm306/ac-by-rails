class ClothGroup < ApplicationRecord
  has_many :cloths

  validates :name, presence: true, uniqueness: true
end
