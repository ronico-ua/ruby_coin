# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.7'

gem 'activeadmin', '~> 3.4'
gem 'after_party'
gem 'ahoy_matey', '~> 5.4', '>= 5.4.1'
gem 'blueprinter'
gem 'bootsnap', require: false
gem 'carrierwave', '~> 3.1', '>= 3.1.2'
gem 'chartkick', '~> 5.2', '>= 5.2.1'
gem 'cssbundling-rails'
gem 'devise'
gem 'friendly_id', '~> 5.6'
gem 'globalize', '~> 7.0'
gem 'groupdate'
gem 'hotwire-rails'
gem 'httparty'
gem 'importmap-rails'
gem 'jsbundling-rails'
gem 'nokogiri'
gem 'pagy', '~> 43.2'
gem 'pg', '~> 1.6', '>= 1.6.2'
gem 'pg_search', '~> 2.3', '>= 2.3.7'
gem 'puma', '~> 7.1'
gem 'pundit', '~> 2.5', '>= 2.5.2'
gem 'pundit-matchers', '~> 4.0'
gem 'rails', '~> 7.2', '>= 7.2.3'
gem 'rails-i18n'
gem 'rbs', '~> 3.1'
gem 'redis'
gem 'sass-rails', '~> 6.0' # Use SCSS for stylesheets
gem 'sidekiq', '~> 7.3', '>= 7.3.10'
gem 'slim'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tinymce-rails', '~> 8.3'
gem 'turbo-rails', '~> 2.0', '>= 2.0.20'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'bundler-audit', '~> 0.9.1'
  gem 'bundler-leak', '~> 0.3.0'
  gem 'dotenv-rails', '~> 3.2'
  gem 'faker'
  gem 'fasterer', '~> 0.11.0'
  gem 'letter_opener'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop', require: false
end

group :development do
  gem 'factory_bot_rails', '~> 6.5', '>= 6.5.1'
  gem 'overcommit', '~> 0.68.0'
  gem 'pry-rails'
  gem 'rubocop-faker', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'

  gem 'capistrano', '~> 3.19', '>= 3.19.2', require: false
  gem 'capistrano3-puma', '~> 7.1', require: false
  gem 'capistrano-bundler', '~> 2.2', require: false
  gem 'capistrano-rails', '~> 1.7', '~> 1.6', require: false
  gem 'capistrano-rbenv', '~> 2.2', require: false
  gem 'capistrano-yarn', '~> 2.0', '>= 2.0.2', require: false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end
