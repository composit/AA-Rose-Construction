set :application, "aaroseconstruction"
set :repository,  "git@github.com:composit/AA-Rose-Construction.git"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :deploy_via, :remote_cache
set :use_sudo, false

require 'capistrano/ext/multistage'
set :stages, %w( staging production )
set :default_stage, 'staging'

require 'bundler/capistrano'

set :scm, :git

server 'aarose', :app, :web, :db, primary: true

namespace :deploy do
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} kill -s USR2 `cat #{current_path}/tmp/pids/unicorn.pid`"
  end
end

after "deploy:restart", "deploy:cleanup"

#before 'deploy:assets:precompile' do
after 'deploy:update_code' do
  run "ln -nfs #{deploy_to}/shared/config/application.yml #{release_path}/config/application.yml"
  run "ln -nfs #{deploy_to}/shared/log #{release_path}/log"
  run "ln -nfs #{deploy_to}/shared/tmp/sockets #{release_path}/tmp/sockets"
end
