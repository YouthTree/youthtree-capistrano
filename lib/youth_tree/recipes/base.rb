YouthTree::Capistrano.load do
  
  def disabled?(feature_name)
    exists?(feature_name) && send(feature_name) == false
  end
  
  def yt_cset(name, *args, &block)
    set(name, *args, &block) unless exists?(name)
  end
  
  def host_for_env(env, host)
    server_hosts[env.to_s] = host.to_s
  end
  
  def bundle_exec(command)
    run "cd '#{latest_release}' && RAILS_ENV='#{rails_env}' bundle exec #{command}"
  end
  
  def symlink_config(shared, current)
    from, to = "#{shared_path}/#{shared}", "#{latest_release}/#{current}"
    run "rm -rf '#{to}' && ln -s '#{from}' '#{to}'"
  end
  
  def lrun(command)
    puts ">> #{command} # Run locally"
    system command
  end
  
  %w(staging production).each do |env_name|
    task env_name.to_sym do
      puts "** Switching stage to #{env_name} **"
      set :stage, env_name
    end
  end
  
  yt_cset :default_stage, "staging"
  yt_cset :use_sudo,      false
  yt_cset :keep_releases, 10
  
  yt_cset(:stage)       { default_stage }
  yt_cset(:rails_env)   { stage }
  yt_cset(:application) { raise "Please Ensure you set the application name." }
  yt_cset(:user)        { application }
  yt_cset(:runner)      { user }
  yt_cset(:group)       { user }
  yt_cset(:deploy_to)   { "/opt/#{application}/#{stage}" }
  
  yt_cset :server_hosts, Hash.new
  
  role(:web)                  { server_hosts[stage] }
  role(:app)                  { server_hosts[stage] }
  role(:db, :primary => true) { server_hosts[stage] }
  
  host_for_env :staging,    "dracorex.youthtree.org.au"
  host_for_env :production, "dryptosaurus.youthtree.org.au"
  
end