YouthTree::Capistrano.load do
  
  namespace :compass do
    
    desc "Forces compass to compile the current stylesheets"
    task :update do
      bundle_exec "compass compile . --force --quiet"
    end
    
  end
  
  after 'deploy:update_code', 'compass:update'
  
end
