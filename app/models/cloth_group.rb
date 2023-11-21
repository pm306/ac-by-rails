class ClothGroup < ApplicationRecord
  has_many :cloths,                 dependent: :destroy
  has_many :cloth_group_selections, dependent: :destroy
  has_many :outfit_selection_rules, through: :cloth_group_selections

  validates :name, presence: true, uniqueness: true
end
