# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'ahoy_matey'
gem 'blueprinter'
gem 'bootsnap', require: false
gem 'carrierwave'
gem 'cssbundling-rails'
gem 'devise'
gem 'friendly_id', '~> 5.5.0'
gem 'friendly_id-globalize', git: 'https://github.com/norman/friendly_id-globalize'
gem 'globalize', git: 'https://github.com/globalize/globalize'
gem 'hotwire-rails'
gem 'jsbundling-rails'
gem 'overcommit', '~> 0.60.0'
gem 'pagy'
gem 'pg', '~> 1.5.3'
gem 'pg_search'
gem 'propshaft'
gem 'puma', '~> 6.4'
gem 'pundit'
gem 'rails', '~> 7.1'
gem 'rails-i18n'
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
  gem 'capistrano3-puma', '6.0.0.beta.1', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-yarn', require: false
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  # gem 'rspec-sidekiq', '~> 3.0', '>= 3.0.3'
  gem 'shoulda-matchers'
end
