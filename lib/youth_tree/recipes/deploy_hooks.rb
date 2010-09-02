YouthTree::Capistrano.load do
  
  namespace :deploy do
    desc "Call unicorn.start"
    task :start, :roles => :app do
      unicorn.start
    end
    
    desc "Call unicorn.stop"
    task :stop, :roles => :app do
      unicorn.stop
    end
    
    desc "Call unicorn.restart"
    task :restart, :roles => :app, :except => { :no_release => true } do
      unicorn.restart
    end
  end
  
end