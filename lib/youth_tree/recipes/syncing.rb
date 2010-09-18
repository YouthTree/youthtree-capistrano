require 'ostruct'
YouthTree::Capistrano.load_named(:syncing) do
  
  yt_cset(:syncing_version_name)       { "#{application}-#{stage}-#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}" }
  yt_cset(:syncing_remote_dir)         { "#{shared_path}/sync" }
  yt_cset(:syncing_current_remote_dir) { "#{syncing_remote_dir}/#{syncing_version_name}" }
  yt_cset(:syncing_current_local_dir)  { "/tmp/#{syncing_version_name}" }
  yt_cset(:syncing_local_archive)      { "#{syncing_current_local_dir}.tar.gz"}
  yt_cset(:syncing_remote_archive)     { "#{syncing_current_remote_dir}.tar.gz"}

  yt_cset :syncing_remote_blacklist, ["production"]

  namespace :sync do

    task :cleanup_remote do
      run "rm -rf #{syncing_current_remote_dir}"
      run "rm -rf #{syncing_remote_archive}"
    end
    
    task :cleanup_local do
      lrun "rm -rf #{syncing_current_local_dir}"
      lrun "rm -rf #{syncing_local_archive}"
    end

    task :prepare do
      run "mkdir -p '#{syncing_remote_dir}'"
    end

    desc "Dumps the remote db to a file"
    task :dump_remote_db do
      run "rm -rf '#{syncing_current_remote_dir}' '#{syncing_remote_archive}'"
      bundle_exec "ydd dump '#{syncing_current_remote_dir}' '#{latest_release}' --env='#{rails_env}'"
      run "cd '#{syncing_current_remote_dir}' && tar czf '#{syncing_remote_archive}' ."
    end
    
    desc "Loads data into the remote db from the given file"
    task :load_remote_db do
      run "mkdir -p '#{syncing_current_remote_dir}'"
      run "cd '#{syncing_current_remote_dir}' && tar xzf '#{syncing_remote_archive}'"
      bundle_exec "ydd load '#{syncing_current_remote_dir}' '#{latest_release}' --env='#{rails_env}'"
    end
    
    desc "Dumps the local db to a file"
    task :dump_local_db do
      lrun "rm -rf '#{syncing_current_local_dir}' '#{syncing_local_archive}'"
      lrun "ydd dump '#{syncing_current_local_dir}' '#{Dir.pwd}'"
      lrun "cd '#{syncing_current_local_dir}' && tar czf '#{syncing_local_archive}' ."
    end
    
    desc "Loads data into the local db from the given file"
    task :load_local_db do
      lrun "mkdir -p '#{syncing_current_local_dir}'"
      lrun "cd '#{syncing_current_local_dir}' && tar xzf '#{syncing_local_archive}'"
      lrun "ydd load '#{syncing_current_local_dir}' '#{Dir.pwd}'"
    end
    
    task :download_remote_db do
      download syncing_remote_archive, syncing_local_archive, :once => true
    end
    
    task :upload_local_db do
      upload syncing_local_archive, syncing_remote_archive, :once => true
    end

    desc "Downloads the database into the current environment from the remote server"
    task :down do
      prepare
      dump_remote_db
      download_remote_db
      cleanup_remote
      load_local_db
    end
    
    desc "Uploads the database for the current environment to the remote server"
    task :up do
      if syncing_remote_blacklist.include?(stage.to_s)
        STDERR.puts "**** Can't upload to #{stage} ****"
        exit 1
      end
      prepare
      dump_local_db
      upload_local_db
      cleanup_local
      load_remote_db
    end

  end
  
end