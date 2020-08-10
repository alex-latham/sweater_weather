namespace :sw do
  desc "This task contains sweater_weather actions"
  task :setup do
    sh "bundle exec figaro install"
    STDOUT.puts "Please enter your Google API key:"
    GOOGLE_API_KEY = STDIN.gets.chomp
    sh "echo GOOGLE_API_KEY: #{GOOGLE_API_KEY} >> config/application.yml"
    STDOUT.puts  "Please enter your OpenWeather API key:"
    OPEN_WEATHER_API_KEY = STDIN.gets.chomp
    sh "echo OPEN_WEATHER_API_KEY: #{OPEN_WEATHER_API_KEY} >> config/application.yml"
    STDOUT.puts  "Please enter your Unsplash client ID:"
    UNSPLASH_CLIENT_ID = STDIN.gets.chomp
    sh "echo UNSPLASH_CLIENT_ID: #{UNSPLASH_CLIENT_ID} >> config/application.yml"
    sh "rake db:setup"
  end
end
