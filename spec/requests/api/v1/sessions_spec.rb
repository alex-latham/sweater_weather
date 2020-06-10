require 'rails_helper'

RSpec.describe 'Client' do
  it 'can successfully post a login' do
    user = create(:user)

    expect(User.count).to eq(1)

    login_params = {
      email: user.email,
      password: user.password
    }

    post api_v1_sessions_path(params: login_params)

    expect(response).to have_http_status(200)
    expect(User.count).to eq(1)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq(user.id.to_s)
    expect(json[:data][:type]).to eq('users')
    expect(json[:data][:attributes][:email]).to eq(user.email)
    expect(json[:data][:attributes][:api_key]).to eq(user.api_key)
  end

  it 'cannot post a login with bad credentials (incorrect password)' do
    user = create(:user)

    expect(User.count).to eq(1)

    login_params = {
      email: user.email,
      password: 'password'
    }

    post api_v1_sessions_path(params: login_params)

    expect(response).to have_http_status(401)
    expect(User.count).to eq(1)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Bad email/password combination")
  end

  it 'cannot post a login with bad credentials (incorrect email)' do
    user = create(:user)

    expect(User.count).to eq(1)

    login_params = {
      email: 'email',
      password: user.password
    }

    post api_v1_sessions_path(params: login_params)

    expect(response).to have_http_status(401)
    expect(User.count).to eq(1)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Bad email/password combination")
  end
end