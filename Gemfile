source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem "rails", "~> 7.0.4"
gem "pg", "~> 1.4.5"
gem "puma", "~> 6.0"

gem "propshaft"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"

gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem "redis"
gem 'sidekiq'
gem 'slim'
gem 'carrierwave'
gem 'devise'

group :development, :test do
  # gem 'letter_opener', '1.7.0'

  # For debugging
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem "web-console"
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-faker', require: false

  # gem 'capistrano-bundler'
  # gem 'capistrano-linked-files'
  # gem 'capistrano-rails'
  # gem 'capistrano-rails-console'
  # gem 'capistrano-rvm'
  # gem 'capistrano3-git-push'
  # gem 'capistrano3-puma'
  # gem 'listen', '3.7.1'
  # gem 'rubocop', '1.21.0', require: false
  # gem 'rubocop-performance', '1.11.5', require: false
  # gem 'rubocop-rails', '2.12.2', require: false
  # gem 'rubocop-rspec', '2.4.0', require: false
  # gem 'rubocop-faker', '1.1.0', require: false
end

group :test do
  gem 'capybara'
  # gem 'database_cleaner'
  # gem 'json_spec'
  gem 'rails-controller-testing'
  # gem 'rspec-html-matchers', '0.9.2'

  # gem 'rspec-sidekiq', '~> 3.0', '>= 3.0.3'
  # gem 'rspec_junit_formatter', '0.3.0'
  gem 'shoulda-matchers'
  # gem 'simplecov', '0.21.2', require: false
  # gem 'stripe-ruby-mock', '3.0.1', require: 'stripe_mock'
  # gem 'vcr', '5.0.0'
  # gem 'webmock', '3.6.0'
end
