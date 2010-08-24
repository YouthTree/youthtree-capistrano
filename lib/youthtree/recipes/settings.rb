YouthTree::Capistrano.load do

  yt_cset :settings_shared_config, 'settings.yml'
  yt_cset :settings_latest_config, 'config/settings.yml'

  namespace :settings do
    
    desc "Create an empty db config"
    task :setup do
      run "touch '#{shared_path}/#{settings_shared_config}'"
    end
    
    desc "Symlinks the settings.yml into place"
    task :symlink do
      symlink_config settings_shared_config, settings_latest_config
    end
    
  end
  
  after 'deploy:setup',       'settings:setup'
  after 'deploy:update_code', 'settings:symlink'
  
end
