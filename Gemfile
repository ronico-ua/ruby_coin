source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'rails', '~> 7.0.4'
gem 'pg', '~> 1.4.5'
gem 'puma', '~> 6.0'

gem 'propshaft'
gem 'jsbundling-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'cssbundling-rails'

gem 'jbuilder'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false

gem 'redis'
gem 'sidekiq'
gem 'slim'
gem 'carrierwave'
gem 'devise'
gem 'pundit'
gem 'pagy'

group :development, :test do
  gem 'letter_opener'

  # For debugging
  gem 'pry'
  gem 'rspec-rails'
  gem 'faker'
end

group :development do
  gem 'web-console'
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
