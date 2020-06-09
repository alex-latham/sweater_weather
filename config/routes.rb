Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#index'
      post '/road_trip', to: 'road_trip#create'
    end
  end
end
