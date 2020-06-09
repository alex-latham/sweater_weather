require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_presence_of(:api_key) }
    it { should validate_uniqueness_of(:api_key) }
    it { should validate_length_of(:api_key).is_equal_to(48) }
  end
end