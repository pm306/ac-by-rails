class Cloth < ApplicationRecord
    #TODO: 最後に選択してからn日経てば再選択可能になるか、というカラム
    belongs_to :user
    belongs_to :cloth_type
  
    has_one_attached :image

    validates :user_id, presence: true
    validates :last_worn_on, presence: true
    validate :last_worn_on_is_date?

    private
    def last_worn_on_is_date?
    errors.add(:last_worn_on, 'must be a valid date') unless last_worn_on.is_a?(Date)
    end
end
