require 'rails_helper'

RSpec.describe 'Client' do
  it 'can post a new user' do
    user = build(:user)

    expect(User.count).to eq(0)

    post api_v1_users_path(
      params: {
        email: user.email,
        password: user.password,
        password_confirmation: user.password
      }
    )

    expect(response).to be_successful
    expect(response).to have_http_status(201)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(User.count).to eq(1)

    expect(json[:data]).to have_key(:id)
    expect(json[:data][:type]).to eq('user')
    expect(json[:data][:attributes][:email]).to eq(user.email)
    expect(json[:data][:attributes][:api_key].chars.length).to eq(48)
  end
end