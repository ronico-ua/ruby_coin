# frozen_string_literal: true

lock '~> 3.18.0'

# Change these
server '45.90.59.143', port: 22, roles: %i[web app db], primary: true
set :application,     'ruby_coin'
set :repo_url,        'git@github.com:ronico-ua/ruby_coin.git'
set :branch,          'master'
set :user,            'root'

set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub] }
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :rails_env,       :production
set :deploy_via,      :remote_cache
set :rvm_ruby_version, '3.2.2'
set :rvm_custom_path, '/usr/local/rvm'

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app,           true
set :puma_worker_timeout,        nil
set :puma_init_active_record,    true
set :puma_enable_socket_service, true
set :keep_releases, 3
set :conditionally_migrate, true
set :puma_systemctl_user, :system

# Issue with propshaft as asset pipwlinw
# See: https://github.com/capistrano/rails/issues/257
# Workaround
set :assets_manifests, lambda {
  [release_path.join('public', fetch(:assets_prefix), '.manifest.json')]
}

append :linked_files, *%w[config/master.key config/database.yml .env]
set :linked_dirs, %w[tmp/pids tmp/sockets tmp/cache vendor/bundle public/uploads public/system node_modules]

after  'deploy:finishing',    :compile_assets
after  'deploy:finishing',    :cleanup
after  'deploy:finishing',    :restart
