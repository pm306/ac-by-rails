class ClothGroupSelection < ApplicationRecord
  belongs_to :outfit_selection_rule
  belongs_to :cloth_group

  validates :selection_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
