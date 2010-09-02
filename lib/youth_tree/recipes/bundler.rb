YouthTree::Capistrano.load_named(:bundler) do
  require 'bundler/capistrano'
  set :bundle_dir, '"$GEM_HOME"'
end
