servers = %w{ ob.gd }

role :app, *servers
role :web, *servers
role :db,  servers.first, :primary => true

set :application, 'releasename'
set :branch,      'experiment'
set :deploy_to,   "/home/releasename"
set :deploy_via,  :remote_cache
set :gateway,     "#{ENV['USER']}@ob.gd"
set :repository,  "git@github.com:dsifry/releasename.git"
set :scm,         :git
set :ssh_options, { :forward_agent => true }
set :user,        'dsifry'

# To install gems remotely:
#   cap invoke COMMAND="sudo gem install haml"

# Override default Capistrano 2.x tasks.
#
namespace :deploy do
  desc 'Deploys your project (with migrations).'
  task :default do
    migrations
  end

  desc 'Deploys and starts a "cold" application.'
  task :cold do
    update
    migrate
    sudo "apachectl restart"
  end

  desc 'Start the application servers.'
  task :start, :roles => :app do
    restart
  end

  desc 'Stop the application servers.'
  task :stop, :roles => :app do
    sudo "apachectl stop"
  end

  desc 'Restart the application servers.'
  task :restart, :roles => :app do
    sudo "apachectl restart"
  end

end

# Customize deployment.
#
after 'deploy:update_code' do
  run "cp #{shared_path}/private/database.yml #{release_path}/config/"
  sudo "sh -c 'cd #{latest_release} && rake gems:install && chown -R #{user}:#{user} #{shared_path}/ruby_inline'"
  run "cd #{release_path}; script/asset_optimizer"
end

# Customize setup.
#
after 'deploy:setup' do
#  put File.read('config/production/authorized_keys'), '.ssh/authorized_keys', :mode => 0600
#  put File.read('config/production/known_hosts'), '.ssh/known_hosts'
#  put File.read('config/production/dot-bashrc'), '.bashrc'
#  sudo "sh -c 'mkdir -p #{shared_path}/ruby_inline && chmod 0755 #{shared_path}/ruby_inline'"
  sudo "touch #{shared_path}/log/production.log"
#  sudo "chown -R #{user}:#{user} ."
#  put File.read('config/production/nginx.conf'), '/tmp/nginx.conf', :mode => 0600
#  sudo "sh -c 'chown root:root /tmp/nginx.conf && mv -f /tmp/nginx.conf /etc/nginx/nginx.conf'"
#  put File.read('config/production/god.conf'), '/tmp/god.conf', :mode => 0600
#  sudo "sh -c 'chown root:root /tmp/god.conf && mv -f /tmp/god.conf /etc/god/conf/#{user}.conf'"
#  puts "!!! You will need to restart god/nginx if its configuration has changed !!!"
end

# Hide uncommon tasks by marking them as internal.
#
%w{ deploy:check deploy:migrate deploy:migrations deploy:pending deploy:pending:diff deploy:rollback:code
    deploy:symlink deploy:update deploy:update_code deploy:upload deploy:web:disable deploy:web:enable
    shell }.each do |name|
  find_task(name).instance_variable_get(:@desc).insert(0, '[internal]')
end
