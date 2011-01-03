YouthTree::Capistrano.load_named(:passenger) do
  
  yt_cset :passenger_restart_file, 'tmp/restart.txt'
  yt_cset :server_name,            'passenger'
  
  namespace :passenger do

    desc "Starts the passenger app server"
    task :start, :roles => :app do
    end

    desc "Stops the passenger app server"
    task :stop, :roles => :app do
    end

    desc "Restarts passenger"
    task :restart, :roles => :app do
      file = File.join(current_path, passenger_restart_file)
      run "mkdir -p '#{File.dirname(file)}' && touch '#{file}'"
    end
    
  end
  
end
