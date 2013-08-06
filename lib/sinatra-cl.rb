require_relative "sinatra-cl/version"

module Sinatra
  module Cl
    class Generate

      def initialize(command, argument)
        if command.chomp == "new"
          `git clone git@github.com:ashleygwilliams/ratpack.git #{argument}`
        end
      end
    end
    # Your code goes here...
  end
end

Sinatra::Cl::Generate.new(@command,@argument)
