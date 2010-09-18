require 'rubygems'
require 'rake'

$:.unshift "lib"
require 'youthtree-capistrano'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "youthtree-capistrano"
    gem.summary     = "Capistrano tasks used for common Youth Tree deployments."
    gem.description = "Capistrano tasks used for common Youth Tree deployments."
    gem.email       = "sutto@sutto.net"
    gem.homepage    = "http://github.com/YouthTree/youthtree-capistrano"
    gem.version     = YouthTree::Capistrano::VERSION
    gem.authors     = ["Darcy Laycock"]
    gem.add_dependency "rvm",     "~> 1.0" 
    gem.add_dependency "bundler", "~> 1.0"
    gem.add_dependency "capistrano"
    gem.add_dependency "ydd"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

