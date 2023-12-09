class ClothType < ApplicationRecord
  has_many :cloths
  belongs_to :cloth_group

  validates :name, presence: true, uniqueness: true
end
