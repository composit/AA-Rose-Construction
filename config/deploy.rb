set :application, "aaroseconstruction"
set :repository,  "git@github.com:composit/AA-Rose-Construction.git"
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :use_sudo, false

require 'capistrano/ext/multistage'
set :stages, %w( murder )
set :default_stage, 'murder'

require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3-p374'
set :rvm_type, :system

require 'bundler/capistrano'

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server 'murder', :app, :web, :db, primary: true

#after 'deploy:update_code' do
#  run "ln -nsf #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
#end

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
