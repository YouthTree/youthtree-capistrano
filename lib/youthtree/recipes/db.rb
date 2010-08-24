YouthTree::Capistrano.load do

  yt_cset :database_shared_config, 'database.yml'
  yt_cset :database_latest_config, 'config/database.yml'

  namespace :database do
    
    desc "Create an empty db config"
    task :setup do
      run "touch '#{shared_path}/#{database_shared_config}'"
    end
    
    desc "Symlinks the database.yml into place"
    task :symlink do
      symlink_config database_shared_config, database_latest_config
    end
    
  end
  
  after 'deploy:setup',       'database:setup'
  after 'deploy:update_code', 'database:symlink'
  
end
