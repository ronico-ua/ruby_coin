# RONICO

Installation
--------------
1. git clone git@github.com:ronico-ua/ronico.git
2. Run `bundle install`
3. Run `yarn`
4. Copy .env settings for database: `cp .env.example .env`
5. Run `rails db:create db:migrate db:seed`

Start server
--------------
1. To start a web server please run `bin/dev` or `s.cmd` if windows
2. Open [http://localhost:3000/](http://localhost:3000/) in your browser

### Stack of technologies
* Ruby version 3.2.0
* Rails version 7.0.4
* PostgreSQL 15.2

* jsbundling-rails
* turbo-rails
* stimulus-rails
* cssbundling-rails
* rbenv
* Capistrano
