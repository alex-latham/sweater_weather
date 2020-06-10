# Sweater Weather

## Versions
* Ruby 2.5.3
* Rails 5.1.7

## Register for Google API Key
To use the Geocoding API you must have an API key. The API key is a unique identifier that is used to authenticate requests associated with your project.
1. Visit the [Google Cloud Platform Console](https://cloud.google.com/console/google/maps-apis/overview).
2. Click the project drop-down and create the project for Sweater Weather.
3. Click the menu button and select APIs & Services > Credentials.
4. On the Credentials page, click Create credentials > API key.
5. The API key created dialog displays your newly created API key.

## Enable Google Geocoding API
Visit the [Geocoding API page](https://console.cloud.google.com/apis/library/geocoding-backend.googleapis.com), ensure Sweater Weather is selected in the drop-down, and click Enable.

## Register for a OpenWeather API Key
Follow the instructions at [OpenWeather's API Guide](https://openweathermap.org/guide#how) to obtain a key.

## Register for an Unsplash Client ID
Follow the instructions at [Unsplash API Documentation](https://unsplash.com/documentation#registering-your-application) to obtain a key.

## Setup
```shell
$ git clone git@github.com:alex-latham/sweater_weather.git
$ cd sweater_weather
$ bundle install
$ bundle exec rake db:setup
$ bundle exec figaro install
$ echo GOOGLE_API_KEY: <Google_API_Key> >> config/application.yml
$ echo OPEN_WEATHER_API_KEY: <OpenWeather_API_Key> >> config/application.yml
$ echo UNSPLASH_CLIENT_ID: <Unsplash_Client_ID> >> config/application.yml
$ rails server
```

## Testing
Run the included RSpec test suite:
```shell
$ bundle exec rspec
```

## API Endpoint Requests & Parameters
GET /api/v1/forecast  
```
location=<city,state>
```

GET /api/v1/backgrounds  
```
location=<city,state>
```

POST /api/v1/users
```
{
  "email": "<email>",
  "password": "<password>",
  "password_confirmation": "<password>"
}
````

POST /api/v1/sessions
```
{
  "email": "<email>",
  "password": "<password>"
}
```

POST /api/v1/road_trip
```
{
  "origin": "<city,state>",
  "destination": "<city,state>",
  "api_key": "<Sweater Weather API Key>"
}
```
