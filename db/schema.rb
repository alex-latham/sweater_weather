ActiveRecord::Schema.define(version: 20_200_607_164_013) do
  enable_extension 'plpgsql'

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'password_digest'
    t.string 'api_key'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
