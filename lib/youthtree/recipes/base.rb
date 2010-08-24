YouthTree::Capistrano.load do
  
  def yt_cset(name, *args, &block)
    set(name, *args, &block) unless exists?(name)
  end
  
  def host_for_env(env, host)
    server_hosts[env.to_s] = host.to_s
  end
  
  def bundle_exec(command)
    run "cd '#{latest_release}' && RAILS_ENV='#{rails_env}' bundle exec #{command}"
  end
  
  yt_cset :rails_env,     "staging"
  yt_cset :use_sudo,      false
  yt_cset :keep_releases, 10
  
  yt_cset(:application) { raise "Please Ensure you set the application name." }
  yt_cset(:user)        { application }
  yt_cset(:runner)      { user }
  yt_cset(:group)       { user }
  yt_cset(:deploy_to)   { "/opt/#{application}/#{rails_env}" }
  
  yt_cset :server_hosts, Hash.new
  
  role(:web)                  { server_hosts[rails_env] }
  role(:app)                  { server_hosts[rails_env] }
  role(:db, :primary => true) { server_hosts[rails_env] }
  
  host_for_env :staging,    "dracorex.youthtree.org.au"
  host_for_env :production, "dryptosaurus.youthtree.org.au"
  
end