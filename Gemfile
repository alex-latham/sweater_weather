source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.7'
gem 'pg'
gem 'puma'
gem "fast_jsonapi"
gem "faraday"
gem "bcrypt"

group :test do
  gem "rspec-rails"
  gem "simplecov"
  gem "webmock"
  gem "vcr"
  gem "shoulda-matchers"
  gem "factory_bot_rails"
  gem "faker"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "figaro"
  gem "rubocop-rails"
  gem "pry"
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

