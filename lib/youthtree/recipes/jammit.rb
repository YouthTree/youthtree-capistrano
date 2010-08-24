YouthTree::Capistrano.load do
  
  namespace :jammit do
    
    desc "Forces jammit to compress / package everything"
    task :update do
      bundle_exec "jammit -f"
    end
    
  end
  
  after 'deploy:update_code', 'jammit:update'
  
end
