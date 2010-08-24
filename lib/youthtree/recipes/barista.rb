YouthTree::Capistrano.load do
  namespace :barista do
    
    desc "Forces barista to compile the current coffeescripts"
    task :update do
      bundle_exec "rake barista:brew"
    end
    
  end
  
  after 'deploy:update_code', 'barista:update'
  
end
