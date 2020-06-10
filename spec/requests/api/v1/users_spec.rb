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

  it 'cannot post a new user with existing email' do
    user1 = create(:user)
    user2 = build(:user)

    expect(User.count).to eq(1)

    user_params = {
      email: user1.email,
      password: user2.password,
      password_confirmation: user2.password
    }

    post api_v1_users_path(params: user_params)

    expect(response).to have_http_status(409)
    expect(User.count).to eq(1)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Email has already been taken")
  end

  it 'cannot post a new user with missing email' do
    user = build(:user)

    expect(User.count).to eq(0)

    user_params = {
      email: nil,
      password: user.password,
      password_confirmation: user.password
    }

    post api_v1_users_path(params: user_params)

    expect(response).to have_http_status(403)
    expect(User.count).to eq(0)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Email can't be blank")
  end

  it 'cannot post a new user with a mismatched password confirmation' do
    user = build(:user)

    expect(User.count).to eq(0)

    user_params = {
      email: user.email,
      password: user.password,
      password_confirmation: 'password'
    }

    post api_v1_users_path(params: user_params)

    expect(response).to have_http_status(403)
    expect(User.count).to eq(0)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Password confirmation doesn't match Password")
  end

  it 'cannot post a new user with a missing password' do
    user = build(:user)

    expect(User.count).to eq(0)

    user_params = {
      email: user.email,
      password: nil,
      password_confirmation: user.password
    }

    post api_v1_users_path(params: user_params)

    expect(response).to have_http_status(403)
    expect(User.count).to eq(0)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Password can't be blank")
  end

  it 'cannot post a new user with a missing password confirmation' do
    user = build(:user)

    expect(User.count).to eq(0)

    user_params = {
      email: user.email,
      password: user.password,
      password_confirmation: nil
    }

    post api_v1_users_path(params: user_params)

    expect(response).to have_http_status(403)
    expect(User.count).to eq(0)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Password confirmation can't be blank")
  end
end