YouthTree::Capistrano.load do
  require 'bundler/capistrano'
  set :bundle_dir, '"$GEM_HOME"'
end
