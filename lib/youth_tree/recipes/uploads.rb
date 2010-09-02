YouthTree::Capistrano.load_named(:uploads) do

  yt_cset :uploads_shared, 'uploads'
  yt_cset :uploads_latest, 'public/uploads'

  namespace :uploads do
    
    desc "Creates an uploads directory in the shared path"
    task :setup do
      run "mkdir -p '#{shared_path}/#{uploads_shared}'"
    end
    
    desc "Symlinks the uploads folder into place"
    task :symlink do
      symlink_config uploads_shared, uploads_latest
    end
    
  end
  
  after 'deploy:setup',       'uploads:setup'
  after 'deploy:update_code', 'uploads:symlink'
  
end
