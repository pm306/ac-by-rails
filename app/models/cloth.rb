class Cloth < ApplicationRecord
    belongs_to :user
    belongs_to :cloth_type, primary_key: :type_name, foreign_key: :type_name
  
    enum category: { tops: 0, bottoms: 1, outerwear: 2}
  
    has_one_attached :image

    validates :user_id, presence: true
    validates :last_worn_on, presence: true
    validate :last_worn_on_is_date?
    validates :type_name, presence: true
    validates :category, presence: true
  
    # 必要な他のバリデーションを追加
    # TODO:画像ファイルの制限, type_nameがcloth_typeのnameに存在するか

    # def category_matches_type
    #     if cloth_type && category != cloth_type.category
    #       errors.add(:category, "must be #{cloth_type.category} for #{cloth_type.name}")
    #     end
    # end

    private
    def last_worn_on_is_date?
    errors.add(:last_worn_on, 'must be a valid date') unless last_worn_on.is_a?(Date)
    end
end
