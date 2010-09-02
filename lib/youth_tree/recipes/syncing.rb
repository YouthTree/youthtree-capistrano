require 'ostruct'
YouthTree::Capistrano.load_named(:syncing) do
  
  yt_cset(:syncing_version_name)   { "#{application}-#{stage}-#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}" }
  yt_cset(:syncing_remote_dir)     { "#{shared_path}/sync" }
  yt_cset(:syncing_remote_archive) { "#{syncing_remote_dir}/#{syncing_version_name}.sql.bz2" }
  yt_cset(:syncing_local_archive)  { "/tmp/#{syncing_version_name}.sql.bz2" }

  yt_cset :syncing_remote_blacklist, ["production"]

  namespace :sync do

    def config_from(text, env = ENV['RAILS_ENV'])
      full_config = YAML.load(text) || {}
      config = full_config[env || "development"] || {}
      OpenStruct.new(config)
    end

    def remote_db_config
      config_from capture("cat '#{shared_path}/#{database_shared_config}'"), rails_env
    end
    
    def local_db_config
      config_from File.read("config/database.yml")
    end
    
    def options_for_config(config)
      host_command = config.host.nil? ? '' : "-h #{config.host}"
      "-u #{config.username} --password='#{config.password}' #{host_command} #{config.database}"
    end
    
    def dump_command_for(config)
      "mysqldump #{options_for_config(config)}"
    end
    
    def load_command_for(config)
      "mysql #{options_for_config(config)}"
    end

    task :cleanup_remote do
      run "rm -rf #{syncing_remote_archive}"
    end
    
    task :cleanup_local do
      run "rm -rf #{syncing_local_archive}"
    end

    task :prepare do
      run "mkdir -p '#{syncing_remote_dir}'"
    end

    desc "Dumps the remote db to a file"
    task :save_remote_db do
      run "#{dump_command_for(remote_db_config)} | bzip2 -9 > #{syncing_remote_archive}"
    end
    
    desc "Loads data into the remote db from the given file"
    task :load_remote_db do
      run "bzip2 -c -d #{syncing_remote_archive} | #{load_command_for(remote_db_config)} && rm -rf #{syncing_remote_archive}"
    end
    
    desc "Dumps the local db to a file"
    task :save_local_db do
      system "#{dump_command_for(local_db_config)} | bzip2 -9 > #{syncing_local_archive}"
    end
    
    desc "Loads data into the local db from the given file"
    task :load_local_db do
      system "bzip2 -c -d #{syncing_local_archive} | #{load_command_for(local_db_config)} && rm -rf #{syncing_local_archive}"
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
      save_remote_db
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
      save_local_db
      upload_local_db
      cleanup_local
      load_remote_db
    end

  end
  
end