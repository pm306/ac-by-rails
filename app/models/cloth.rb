class Cloth < ApplicationRecord
  default_scope { where(deleted_at: nil) }
  
  #TODO: 最後に選択してからn日経てば再選択可能になるか、というカラム
  belongs_to :user
  belongs_to :cloth_type
  has_many :outfit_logs_clothes
  has_many :outfit_logs, through: :outfit_logs_clothes

  has_one_attached :image

  validates :user_id, presence: true
  validates :last_worn_on, presence: true
  validates :image, presence: true  # ここに追加    
  validate :last_worn_on_is_date?

  def soft_delete
      update(deleted_at: Time.current)
  end

  private
  def last_worn_on_is_date?
      errors.add(:last_worn_on, 'must be a valid date') unless last_worn_on.is_a?(Date)
  end
end
