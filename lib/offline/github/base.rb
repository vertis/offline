module Offline
  module Github
    class Base
      include Offline::Helpers

      def initialize(user, options)

      end

      private
        def clone(source, target="", mirror=false)
          run("git clone #{"--mirror" if mirror} #{source} #{target}")
        end
    end
  end
end
