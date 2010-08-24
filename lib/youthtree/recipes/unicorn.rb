YouthTree::Capistrano.load do
  
  yt_cset :unicorn_shared_config, 'unicorn.rb'
  yt_cset :unicorn_latest_config, 'config/unicorn.rb'
  yt_cset :unicorn_pid_file,    'tmp/pids'
  
  namespace :unicorn do
    
    def signal!(signal)
      pid_file = "tmp/pids/unicorn.pid"
      run "cd '#{current_path}' && [ -f #{pid_file} ] && kill -#{signal} `cat #{pid_file}`"
    end

    desc "Creates a blank unicorn config file"
    task :setup, :roles => :app do
      run "touch '#{shared_path}/#{unicorn_shared_config}'"
    end
    
    desc "Symlinks the unicorn config into place"
    task :symlink, :roles => :app do
      symlink_config unicorn_shared_config, unicorn_latest_config
    end

    desc "Starts the unicorn app server"
    task :start, :roles => :app do
      run "cd '#{current_path}' && bundle exec unicorn_rails -D -E #{rails_env} -c '#{current_path}/#{unicorn_latest_config}'"
    end

    desc "Stops the unicorn app server"
    task :stop, :roles => :app do
      signal! :QUIT
    end

    desc "Restarts unicorn (via a signal)"
    task :restart, :roles => :app do
      signal! :USR2
    end
    
  end
  
  after 'deploy:setup',       'unicorn:setup'
  after 'deploy:update_code', 'unicorn:symlink'
  
end
