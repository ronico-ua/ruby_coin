

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key',
                  "#{shared_path}/config/master.key"
        end
        unless test("[ -f #{shared_path}/config/database.yml ]")
          upload! 'config/database.yml',
                  "#{shared_path}/config/database.yml"
        end
        unless test("[ -f #{shared_path}/.env ]")
          upload! '.env',
                  "#{shared_path}/.env"
        end
      end
    end
  end

  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      # Update this to your branch name: master, main, etc. Here it's main
      # unless `git rev-parse HEAD` == `git rev-parse origin/master`
      #   puts 'WARNING: HEAD is not the same as origin/master'
      #   puts 'Run `git push` to sync changes.'
      #   exit
      # end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'reload the database with seed data'
  task :seed do
    puts "\n=== Seeding Database ===\n"
    on primary :db do
      within current_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end
