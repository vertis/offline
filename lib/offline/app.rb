module Offline
  class App < Thor
    include Offline::Helpers

    desc "mirror GITHUB_USER", "mirror the repositories of a given github user"
    method_option :only, :type => :array, :required => false
    method_option :without, :type => :array, :required => false
    method_option :password, :type => :string, :required => false, :aliases => '-p'
    method_option :output, :type => :string, :default => 'mirror', :required => false, :aliases => '-o'
    def mirror(user)
      mirror_directory = "#{options[:output]}/#{user}"
      Pathname.new(mirror_directory).mkpath
      reaper = Offline::Github.new(user, options[:password])
      all_repos = reaper.repositories.map {|r| r["name"] }
      repos =  all_repos & (options[:only] || all_repos) # TODO: Might be a better way of doing this
      repos = (repos) - Array(options[:without])
      reaper.repositories.each do |repo|
        next unless repos.include?(repo["name"])
        puts "Mirroring: #{repo["name"]}"
        target_directory = Pathname.new("#{mirror_directory}/#{repo["name"]}.git")
        if target_directory.exist?
          run("cd #{target_directory} && git fetch")
        else
          run("git clone --mirror git@github.com:#{repo["owner"]}/#{repo["name"]}.git #{target_directory}")
        end
        puts "" # blank line
      end
    end

    # TODO: Dry up
    # Yes I did just copy and paste
    desc "clone GITHUB_USER", "clone the repositories of a given github user"
    method_option :only, :type => :array, :required => false
    method_option :without, :type => :array, :required => false
    method_option :password, :type => :string, :required => false, :aliases => '-p'
    method_option :output, :type => :string, :default => 'clone', :required => false, :aliases => '-o'
    def clone(user)
      clone_directory = "#{options[:output]}/#{user}"
      Pathname.new(clone_directory).mkpath
      reaper = Offline::Github.new(user, options[:password])
      all_repos = reaper.repositories.map {|r| r["name"] }
      repos =  all_repos & (options[:only] || all_repos) # TODO: Might be a better way of doing this
      repos = (repos) - Array(options[:without])
      reaper.repositories.each do |repo|
        next unless repos.include?(repo["name"])
        puts "Cloning: #{repo["name"]}"
        target_directory = Pathname.new("#{clone_directory}/#{repo["name"]}")
        if target_directory.exist?
          run("cd #{target_directory} && git fetch")
        else
          run("git clone git@github.com:#{repo["owner"]}/#{repo["name"]}.git #{target_directory}")
        end
        puts "" # blank line
      end
    end
  end
end
