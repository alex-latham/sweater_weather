FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.hex(24) }
    api_key { SecureRandom.hex(24) }
  end
end
