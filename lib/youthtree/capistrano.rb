module YouthTree
  module Capistrano
    VERSION = "0.0.2".freeze
    
    def self.load(&blk)
      ::Capistrano::Configuration.instance(:must_exist).load(&blk)
    end
    
    def self.load_recipe!(*names)
      names.flatten.each { |name| require "youthtree/recipes/#{name}" }
    end
    
    def self.load_named(name, &blk)
      load { load(&blk) unless disabled?(name) }
    end
    
    def self.load_all!
      load_recipe! %w(base rvm git bundler settings db unicorn compass barista jammit uploads)
      load { load 'deploy' }
      load_recipe! 'deploy_hooks'
    end
    
  end
end