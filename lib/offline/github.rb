module Offline
  class Github
    include HTTParty
    base_uri 'http://github.com/api/v2/json'

    attr_reader :username

    def initialize(user, pass=nil)
      @username = user
      if pass
        self.class.basic_auth user, pass
        if self.class.get("/user/show").parsed_response["error"]=="not authorized"
          raise Exception.new({"error"=>"not authorized"})
        end
      end
    end

    def repositories(owner=nil, privacy=:all)
      owner ||= @username
      repos = self.class.get("/repos/show/#{owner}").parsed_response["repositories"]
      if privacy==:"private-only"
        repos = repos.select {|r| r["private"]==true } 
      end
      repos
    end
  end
end