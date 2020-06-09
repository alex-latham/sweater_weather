require 'rails_helper'

RSpec.describe 'Client' do
  it 'can post a login' do
    user = create(:user)

    expect(User.count).to eq(1)

    post api_v1_sessions_path(
      params: {
        email: user.email,
        password: user.password
      }
    )

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data]).to have_key(:id)
    expect(json[:data][:type]).to eq('user')
    expect(json[:data][:attributes][:email]).to eq(user.email)
    expect(json[:data][:attributes][:api_key].chars.length).to eq(48)
    expect(User.count).to eq(1)
  end
end