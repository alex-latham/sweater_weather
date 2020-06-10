require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:api_key) }
    it { should validate_uniqueness_of(:api_key) }
  end

  describe 'instance methods' do
    it 'initialize account' do
      user_build = build(:user)
      user_params = {
        email: user_build.email,
        password: user_build.password,
        password_confirmation: user_build.password
      }

      user = User.initialize_account(user_params)

      expect(user).to be_a(User)
      expect(user.new_record?).to eq(true)
    end
  end
end