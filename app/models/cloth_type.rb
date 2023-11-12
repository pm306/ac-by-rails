class ClothType < ApplicationRecord
    has_many :cloths
    belong_to :cloth_groups

    validates :name, presence: true, uniqueness: true
end
