# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_many :clothes
  has_many :outfit_logs, dependent: :destroy

  validates :name, presence: true, length: { maximum: 16 }
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { email.blank? }
  validates :password, presence: true
  validates :password, length: { minimum: 8, maximum: 16 }, unless: -> { password.blank? }
  has_secure_password
end
