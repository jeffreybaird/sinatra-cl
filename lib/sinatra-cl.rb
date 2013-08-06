require_relative "sinatra-cl/version"

module Sinatra
  module Cl
    class Generate

      def initialize(command, argument=nil)
        if command == "new"
          argument = "sinatra-app" if argument.nil?
          `git clone git@github.com:ashleygwilliams/ratpack.git #{argument}`
        end
      end
    end
    # Your code goes here...
  end
end

Sinatra::Cl::Generate.new(@command,@argument)
