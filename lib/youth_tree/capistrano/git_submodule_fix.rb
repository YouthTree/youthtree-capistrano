require 'capistrano/recipes/deploy/scm/git'

Capistrano::Deploy::SCM::Git.class_eval do
  
  # Performs a clone on the remote machine, then checkout on the branch you want to deploy.
  # This differs from the normal version in that it adds recursive to the --update command.
  def checkout(revision, destination)
    git    = command
    remote = origin

    args = []
    args << "-o #{remote}" unless remote == 'origin'
    if depth = variable(:git_shallow_clone)
      args << "--depth #{depth}"
    end

    execute = []
    if args.empty?
      execute << "#{git} clone #{verbose} #{variable(:repository)} #{destination}"
    else
      execute << "#{git} clone #{verbose} #{args.join(' ')} #{variable(:repository)} #{destination}"
    end

    # checkout into a local branch rather than a detached HEAD
    execute << "cd #{destination} && #{git} checkout #{verbose} -b deploy #{revision}"
    
    if variable(:git_enable_submodules)
      execute << "#{git} submodule #{verbose} init"
      execute << "#{git} submodule #{verbose} sync"
      execute << "#{git} submodule #{verbose} update --recursive"
    end

    execute.join(" && ")
  end
  
end