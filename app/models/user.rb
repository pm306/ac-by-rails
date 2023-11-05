class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 16 }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true
end
