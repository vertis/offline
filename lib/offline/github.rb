module Offline
  class Github
    include HTTParty
    base_uri 'http://github.com/api/v2/json'

    attr_reader :username

    def initialize(user, pass=nil)
      @username = user
      if pass
        self.class.basic_auth user, pass
      end
    end

    def repositories(privacy=:all)
      repos = self.class.get("/repos/show/#{@username}").parsed_response["repositories"]
      if privacy==:"private-only"
        repos = repos.select {|r| r["private"]==true } 
      end
      repos
    end
  end
end