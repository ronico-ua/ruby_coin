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

append :linked_files, *%w[config/master.key config/database.yml .env]
set :linked_dirs, %w[tmp/pids tmp/sockets tmp/cache vendor/bundle public/uploads public/system node_modules]

# before 'puma:restart', :after_party

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        files_to_upload = [
          { file: 'config/credentials.yml.enc' },
          { file: 'config/master.key' },
          { file: 'config/database.yml' },
          { file: '.env' }
        ]

        files_to_upload.each do |file|
          upload! file[:file], "#{shared_path}/#{file[:file]}" unless test("[ -f #{shared_path}/#{file[:file]} ]")
        end
      end
    end
  end
end
