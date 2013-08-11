require_relative "sinatra-cl/version"
require_relative "files"
require_relative "directory"
require_relative "flag"
require 'rake'
require 'fileutils'

module Sinatra
  module Cl
    class Build
      attr_accessor :app_name
      attr_reader :command, :flags

      def initialize(user_input)
        @command = user_input[0]
        @app_name = user_input[1]
        @flags = parse_flags(user_input[2..-1])
      end

      def parse_flags(flags)
        flags.map{|flag_name| Flag.new(flag_name).check_flag}
      end

      def execute_new(app_name)
        app_name = "sinatra-app" if app_name.nil?
        parent
        files
      end

      def app
        case command
        when "new"
          execute_new(app_name)
        when "help"
          "Usage:\nnew: sinatra-cl new [APPNAME]"
        else
          "#{command} is not a valid command.\nType 'sinatra-cl help' for more information"
        end
      end

      def parent
        Sinatra::Cl::Directory.new(app_name, flags).build
      end

      def files
        Sinatra::Cl::Files.new(app_name, flags).build
      end


    end
  end
end

s = Sinatra::Cl::Build.new(@input)
s.app
