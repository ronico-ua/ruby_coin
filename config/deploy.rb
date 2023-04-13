# config valid for current version and patch releases of Capistrano
lock "~> 3.17.2"

server '45.90.59.143', port: 22, roles: %i[web app db], primary: true

# Change these
set :application,  'ronico'
set :repo_url,     'git@github.com:ronico-ua/ronico.git'
set :branch,       :master
set :user,         'root'
set :deploy_to,    "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,  { forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub] }
set :stage,        :production

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub] }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord

append :linked_files, *%w[config/master.key config/database.yml]
append :linked_dirs, 'public/uploads'
