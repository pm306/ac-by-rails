class ClothType < ApplicationRecord
    has_many :cloths, primary_key: :type_name, foreign_key: :type_name

    validates :type_name, presence: true, uniqueness: true
    enum category: { tops: 0, bottoms: 1, outerwear: 2}
end
