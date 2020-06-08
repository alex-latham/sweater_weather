FactoryBot.define do
  factory :current_forecast do
    skip_create

    hash { Hash.new }
  end
end
