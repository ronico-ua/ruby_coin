# RubyCoin

Preinstallation
--------------
### PostgreSQL setup

1. Install postgresql if you don't have it
2. Create a `dev` user: `sudo -u postgres createuser -d -W dev` and enter password `dev`
3. Install nodeJS v18.15.0 or higher

Installation
--------------
1. git clone git@github.com:ronico-ua/ruby_coin.git
2. Run `bundle install`
3. Run `overcommit --install`
4. Run `overcommit --sign`
5. Run `yarn`
6. Run `rails db:create db:migrate db:seed`

Start server
--------------
1. To start a web server please run `bin/dev` or `s.cmd` if windows
2. Open [http://localhost:3000/](http://localhost:3000/) in your browser

### Stack of technologies
* Ruby       3.3.6
* Rails      7.1
* PostgreSQL 15.2
* NodeJS    18.15.0 or higher
* Yarn       4.0.2


### How to skip `overcommit` (only if very needed):
`SKIP=RuboCop git commit`
