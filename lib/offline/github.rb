module Offline
  class Github
    include HTTParty
    base_uri 'https://api.github.com'
    headers 'User-Agent' => "Offline v#{Offline::VERSION} - https://github.com/vertis/offline"

    attr_reader :username

    def initialize(user, pass=nil)
      @username = user
      if pass
        self.class.basic_auth user, pass
        response = self.class.get("/user")
        if response.code >= 400 && response.code < 500
          raise Exception.new({ "code" => response.code, "error" => response.parsed_response["message"] })
        end
        @login = response['login']
      end
    end

    def repositories(owner, privacy=:all)
      res = nil
      repos = []
      if owner == @login
        repos = self.class.get("/user/repos?per_page=100").parsed_response
        repos += self.class.get("/user/repos?page=2&per_page=100").parsed_response
        repos += self.class.get("/user/repos?page=3&per_page=100").parsed_response
        repos += self.class.get("/user/repos?page=4&per_page=100").parsed_response
      else
        res = self.class.get("/users/#{owner}/repos?per_page=100")
        if res.code == 404
          res = self.class.get("/orgs/#{owner}/repos?per_page=100").parsed_response
        end
        repos = res.parsed_response
      end
      if privacy==:"private-only"
        repos = repos.select {|r| r["private"]==true }
      end
      repos
    end
  end
end
