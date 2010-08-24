YouthTree::Capistrano.load do

  yt_cset :uploads_shared, 'uploads'
  yt_cset :uploads_latest, 'public/uploads'

  namespace :uploads do
    
    desc "Creates an uploads directory in the shared path"
    task :setup do
      run "mkdir -p '#{shared_path}/#{uploads_shared}'"
    end
    
    desc "Symlinks the uploads folder into place"
    task :symlink do
      from, to = "#{shared_path}/#{uploads_shared}", "#{latest_release}/#{uploads_latest}"
      run "rm -rf '#{to}' && ln -s '#{from}' '#{to}'"
    end
    
  end
  
  after 'deploy:setup',       'uploads:setup'
  after 'deploy:update_code', 'uploads:symlink'
  
end
