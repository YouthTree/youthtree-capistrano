YouthTree::Capistrano.load do
  yt_cset(:yt_default_ruby) { "ree" }
  yt_cset(:rvm_ruby_string)  { "#{yt_default_ruby}@#{application}" }
  require 'rvm/capistrano'
end
