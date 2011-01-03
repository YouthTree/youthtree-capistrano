YouthTree::Capistrano.load do
  
  namespace :deploy do
    desc "Call start on your server"
    task :start, :roles => :app do
      send(server_name.to_sym).start
    end
    
    desc "Call stop on your server"
    task :stop, :roles => :app do
      send(server_name.to_sym).stop
    end
    
    desc "Call restart on your server"
    task :restart, :roles => :app, :except => { :no_release => true } do
      send(server_name.to_sym).restart
    end
  end
  
end