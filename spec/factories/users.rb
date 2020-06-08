FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_hash { SecureRandom.hex(31) }
    api_key { SecureRandom.hex(16) }
  end
end
