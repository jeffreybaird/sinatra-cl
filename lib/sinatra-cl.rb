require_relative "sinatra-cl/version"

module Sinatra
  module Cl
    class Generate
      attr_reader :command, :argument

      def initialize(user_input)
        @command, @argument = user_input
      end

      def execute_new(argument)
        argument = "sinatra-app" if argument.nil?
        `git clone git@github.com:ashleygwilliams/ratpack.git #{argument}`
      end

      def build_app
        case command
        when "new"
          execute_new(argument)
        when "help"
          "Usage:\nnew: sinatra-cl new [APPNAME]"
        else
          "#{command} is not a valid command.\nType 'sinatra-cl help' for more information"
        end
      end

    end
  end
end

Sinatra::Cl::Generate.new(@input).build_app
