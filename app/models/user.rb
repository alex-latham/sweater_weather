class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password_confirmation, presence: true
  validates :api_key, presence: true
  validates :api_key, uniqueness: true

  has_secure_password

  def self.initialize_account(user_params)
    new(
      email: user_params[:email],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
      api_key: SecureRandom.hex(24)
    )
  end
end
