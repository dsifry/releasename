servers = %w{ ob.gd }

role :app, *servers
role :web, *servers
role :db,  servers.first, :primary => true

set :application, 'releasename'
set :branch,      'master'
set :deploy_to,   "/home/releasename"
set :deploy_via,  :remote_cache
set :gateway,     "#{ENV['USER']}@ob.gd"
set :repository,  "git://github.com/dsifry/releasename.git"
set :scm,         :git
set :ssh_options, { :forward_agent => true }
set :user,        'dsifry'

# To install gems remotely:
#   cap invoke COMMAND="sudo gem install haml"

# Override default Capistrano 2.x tasks.
#
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end