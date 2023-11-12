class OutfitSelectionRule < ApplicationRecord
  has_many :cloth_group_selections, dependent: :destroy

  validates :name,     presence: true, uniqueness: true
  validates :priority, presence: true
end
