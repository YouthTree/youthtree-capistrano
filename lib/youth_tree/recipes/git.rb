YouthTree::Capistrano.load_named(:git) do
  yt_cset :scm,             :git
  yt_cset(:repository_name) { application }
  yt_cset(:repository)      { "git://github.com/YouthTree/#{repository_name}.git" }
end