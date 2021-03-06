# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{youthtree-capistrano}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Darcy Laycock"]
  s.date = %q{2011-01-03}
  s.description = %q{Capistrano tasks used for common Youth Tree deployments.}
  s.email = %q{sutto@sutto.net}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
    "Rakefile",
    "lib/youth_tree/capistrano.rb",
    "lib/youth_tree/capistrano/git_submodule_fix.rb",
    "lib/youth_tree/recipes/barista.rb",
    "lib/youth_tree/recipes/base.rb",
    "lib/youth_tree/recipes/bundler.rb",
    "lib/youth_tree/recipes/compass.rb",
    "lib/youth_tree/recipes/db.rb",
    "lib/youth_tree/recipes/deploy_hooks.rb",
    "lib/youth_tree/recipes/git.rb",
    "lib/youth_tree/recipes/jammit.rb",
    "lib/youth_tree/recipes/passenger.rb",
    "lib/youth_tree/recipes/rvm.rb",
    "lib/youth_tree/recipes/settings.rb",
    "lib/youth_tree/recipes/syncing.rb",
    "lib/youth_tree/recipes/unicorn.rb",
    "lib/youth_tree/recipes/uploads.rb",
    "lib/youthtree-capistrano.rb",
    "youthtree-capistrano.gemspec"
  ]
  s.homepage = %q{http://github.com/YouthTree/youthtree-capistrano}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Capistrano tasks used for common Youth Tree deployments.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rvm>, ["~> 1.0"])
      s.add_runtime_dependency(%q<bundler>, ["~> 1.0"])
      s.add_runtime_dependency(%q<capistrano>, [">= 0"])
      s.add_runtime_dependency(%q<ydd>, [">= 0"])
    else
      s.add_dependency(%q<rvm>, ["~> 1.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<capistrano>, [">= 0"])
      s.add_dependency(%q<ydd>, [">= 0"])
    end
  else
    s.add_dependency(%q<rvm>, ["~> 1.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<capistrano>, [">= 0"])
    s.add_dependency(%q<ydd>, [">= 0"])
  end
end

