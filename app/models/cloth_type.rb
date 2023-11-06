class ClothType < ApplicationRecord
    has_many :cloths, primary_key: :type_name, foreign_key: :type_name

    validates :type_name, presence: true, uniqueness: true
    validates :category, presence: true
end
