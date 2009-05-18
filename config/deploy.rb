#############################################################
#	Application
#############################################################
require 'capistrano/ext/multistage'
set :stages, %w(production staging)
set( :application ) { "bidstore_#{ stage }" }
set( :deploy_to )   { "/var/app/#{application}" }

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, false
set :local_scm_command, "/usr/local/git/bin/git"
set :keep_releases, 3
set :git_enable_submodules, 1

#############################################################
#	Servers
#############################################################

set :user, "rsmith"
set :domain, "10.0.1.20"
server domain, :app, :web
role :db, domain, :primary => true


#############################################################
#	Git
#############################################################
set :scm, :git
set :repository, "git@github.com:ryandotsmith/bidstore.git"
set :branch, "master"
set :deploy_via, :remote_cache


#############################################################
#	Passenger
#############################################################
namespace :deploy do
  
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
    run "mkdir #{current_path}/tmp/sessions"
  end

  desc "Symlink shared configs and folders on each release."
    task :symlink_shared do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
      
end
after 'deploy:update_code', 'deploy:symlink_shared'
#############################################################
#	Attachment_FU 
#############################################################
