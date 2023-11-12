class ClothGroup < ApplicationRecord
  has_many :cloths,                 dependent: :destroy
  has_many :cloth_group_selections, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
