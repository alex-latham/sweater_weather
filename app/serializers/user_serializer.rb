class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :api_key
  set_type :users
end
