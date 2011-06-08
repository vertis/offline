module Offline
  module Helpers
    def run(command)
      puts "Running: #{command}"
      system(command)
    end
  end
end