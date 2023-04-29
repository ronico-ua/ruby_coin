# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'bootsnap', require: false
gem 'carrierwave'
gem 'cssbundling-rails'
gem 'devise'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'overcommit', '~> 0.60.0'
gem 'pagy'
gem 'pg', '~> 1.5.3'
gem 'propshaft'
gem 'puma', '~> 5.6', '>= 5.6.5'
gem 'pundit'
gem 'rails', '~> 7.0.4'
gem 'rbs', '~> 3.1'
gem 'redis'
gem 'sidekiq'
gem 'slim'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'bundler-audit', '~> 0.9.1'
  gem 'bundler-leak', '~> 0.3.0'
  gem 'dotenv-rails', '~> 2.8.1'
  gem 'faker'
  gem 'fasterer', '~> 0.10.0'
  gem 'letter_opener'
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-faker', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'

  gem 'capistrano', '~> 3.17', require: false
  gem 'capistrano3-puma', '~> 5.2', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-yarn', require: false
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
  # gem 'rspec-html-matchers', '0.9.2'

  # gem 'rspec-sidekiq', '~> 3.0', '>= 3.0.3'
  # gem 'rspec_junit_formatter', '0.3.0'
  gem 'shoulda-matchers'
  # gem 'vcr', '5.0.0'
  # gem 'webmock', '3.6.0'
end
