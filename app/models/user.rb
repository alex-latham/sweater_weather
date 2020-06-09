class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :api_key, presence: true
  validates :api_key, uniqueness: true
  
  has_secure_password
end
