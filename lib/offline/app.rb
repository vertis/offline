module Offline
  class App < Thor
    include Offline::Helpers

    desc "mirror GITHUB_REPOSITORY_OWNER", "mirror the repositories of a given github user"
    method_option :only, :type => :array, :required => false
    method_option :without, :type => :array, :required => false
    method_option :"private-only", :type => :boolean, :aliases => '-P'
    method_option :username, :type => :string, :required => false, :aliases => '-u'
    method_option :password, :type => :string, :required => false, :aliases => '-p'
    method_option :output, :type => :string, :default => 'mirror', :required => false, :aliases => '-o'
    def mirror(owner)
      do_clone(owner, :mirror, options)
    end
    
    desc "clone GITHUB_REPOSITORY_OWNER", "clones the repositories of a given github user"
    method_option :only, :type => :array, :required => false
    method_option :without, :type => :array, :required => false
    method_option :"private-only", :type => :boolean, :aliases => '-P'
    method_option :username, :type => :string, :required => false, :aliases => '-u'
    method_option :password, :type => :string, :required => false, :aliases => '-p'
    method_option :output, :type => :string, :default => 'clone', :required => false, :aliases => '-o'
    def clone(owner)
      do_clone(owner, :clone, options)
    end
    
    private
      def do_clone(owner, clone_type, options)
        privacy = options["private-only"] ? :"private-only" : :all
        mirror_directory = "#{options[:output]}/#{owner}"
        Pathname.new(mirror_directory).mkpath
        user = options[:username] || owner
        reaper = Offline::Github.new(user, options[:password])
        all_repos = reaper.repositories(owner, privacy).map {|r| r["name"] }
        repos =  all_repos & (options[:only] || all_repos) # TODO: Might be a better way of doing this
        repos = (repos) - Array(options[:without])
        
        reaper.repositories(owner, privacy).each do |repo|
          next unless repos.include?(repo["name"])
          puts "#{clone_type}: #{repo["name"]}"
          target_directory = Pathname.new("#{mirror_directory}/#{repo["name"]}.git")
          if target_directory.exist?
            run("cd #{target_directory} && git fetch")
          else
            run("git clone #{"--mirror" if clone_type==:mirror} git@github.com:#{repo['full_name']}.git #{target_directory}")
          end
          puts "" # blank line
        end
      end
  end
end
