class User < ApplicationRecord
  has_many :clothes, dependent: :destroy
  has_many :outfit_logs

  validates :name, presence: true, length: { maximum: 16 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  has_secure_password
end
