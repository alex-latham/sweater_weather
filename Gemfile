source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem "fast_jsonapi", "~> 1.5"
gem "faraday", "~> 1.0"
gem "bcrypt", "~> 3.1"

group :test do
  gem "rspec-rails", "~> 4.0"
  gem "simplecov", "~> 0.18.5"
  gem "webmock", "~> 3.8"
  gem "vcr", "~> 6.0"
  gem "shoulda-matchers", "~> 4.3"
  gem "factory_bot_rails", "~> 5.2"
  gem "faker", "~> 2.12"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "figaro", "~> 1.2"
  gem "rubocop-rails", "~> 2.5"
  gem "pry", "~> 0.13.1"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
