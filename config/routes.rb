Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#index'
      get '/road_trip', to: 'road_trip#index'
    end
  end
end
