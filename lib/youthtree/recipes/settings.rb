YouthTree::Capistrano.load do

  yt_cset :settings_shared_config, 'settings.yml'
  yt_cset :settings_latest_config, 'config/settings.yml'

  namespace :settings do
    
    desc "Create an empty db config"
    task :setup do
      run "mkdir -p '#{shared_path}/#{settings_shared_config}'"
    end
    
    desc "Symlinks the settings.yml into place"
    task :symlink do
      from, to = "#{shared_path}/#{settings_shared_config}", "#{latest_release}/#{settings_latest_config}"
      run "rm -rf '#{to}' && ln -s '#{from}' '#{to}'"
    end
    
  end
  
  after 'deploy:setup',       'settings:setup'
  after 'deploy:update_code', 'settings:symlink'
  
end
