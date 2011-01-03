YouthTree::Capistrano.load_named(:bundler) do
  require 'bundler/capistrano'
  set :bundle_dir,   nil
  set :bundle_flags, '--quiet'
end
