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
gem 'pg', '~> 1.4.5'
gem 'propshaft'
gem 'puma', '~> 6.0'
gem 'pundit'
gem 'rails', '~> 7.0.4'
gem 'rbs', '~> 3.0.4'
gem 'redis'
gem 'sidekiq'
gem 'slim'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'bundler-audit', '~> 0.9.1'
  gem 'bundler-leak', '~> 0.3.0'
  gem 'faker'
  gem 'fasterer', '~> 0.10.1'
  gem 'letter_opener'
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-faker', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'

  # gem 'capistrano-bundler'
  # gem 'capistrano-linked-files'
  # gem 'capistrano-rails'
  # gem 'capistrano-rails-console'
  # gem 'capistrano-rvm'
  # gem 'capistrano3-git-push'
  # gem 'capistrano3-puma'
  # gem 'listen', '3.7.1'
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
  # gem 'vcr', '5.0.0'
  # gem 'webmock', '3.6.0'
end
