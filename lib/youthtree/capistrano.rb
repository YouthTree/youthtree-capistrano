module YouthTree
  module Capistrano
    VERSION = "0.0.1".freeze
    
    def self.load!(&blk)
      Capistrano::Configuration.instance(:must_exist).load(&blk)
    end
    
    def self.load_recipe!(*names)
      names.flatten.each { |name| require "youthtree/recipes/#{name}" }
    end
    
    def self.load_all!
      load_recipe! %w(base git bundler settings db unicorn compass barista jammit uploads)
      load! { load 'deploy' }
      load_recipe! 'deploy_hooks'
    end
    
  end
end