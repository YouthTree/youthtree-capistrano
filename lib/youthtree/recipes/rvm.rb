YouthTree::Capistrano.load do
  require 'rvm/capistrano'
  yt_cset(:rvm_default_ruby) { "ree" }
  yt_cset(:rvm_ruby_string)  { "#{rvm_default_ruby}@#{}" }
end
