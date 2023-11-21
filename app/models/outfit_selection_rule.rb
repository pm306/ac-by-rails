class OutfitSelectionRule < ApplicationRecord
  has_many :cloth_group_selections, dependent: :destroy
  has_many :cloth_groups, through: :cloth_group_selections

  validates :name,     presence: true, uniqueness: true
  validates :priority, presence: true
end
