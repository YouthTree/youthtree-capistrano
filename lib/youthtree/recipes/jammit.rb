YouthTree::Capistrano.load_named(:jammit) do
  
  namespace :jammit do
    
    desc "Forces jammit to compress / package everything"
    task :update do
      bundle_exec "jammit --force"
    end
    
  end
  
  after 'deploy:update_code', 'jammit:update'
  
end
