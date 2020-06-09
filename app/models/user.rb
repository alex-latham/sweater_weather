class User < ApplicationRecord
  has_secure_password

  validates :email, :password, :api_key, presence: true
  validates :email, uniqueness: true
  validates :api_key, uniqueness: true
end
