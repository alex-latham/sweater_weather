require 'rails_helper'

RSpec.describe 'Client' do
  it 'can post a new user' do
    user = build(:user)

    expect(User.count).to eq(0)

    user_params = {
      email: user.email,
      password: user.password,
      password_confirmation: user.password
    }

    post api_v1_users_path(params: user_params)
    
    expect(response).to have_http_status(201)
    expect(User.count).to eq(1)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq(User.last.id.to_s)
    expect(json[:data][:type]).to eq('users')
    expect(json[:data][:attributes][:email]).to eq(user.email)
    expect(json[:data][:attributes][:api_key].chars.length).to eq(48)
  end
end