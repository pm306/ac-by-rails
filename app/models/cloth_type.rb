class ClothType < ApplicationRecord
  has_many :clothes
  belongs_to :cloth_group

  validates :name, presence: true, uniqueness: true
end
