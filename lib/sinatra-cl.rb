require_relative "sinatra-cl/version"
require 'rake'
require 'fileutils'

module Sinatra
  module Cl
    class Build
      attr_reader :command, :argument

      def initialize(user_input)
        @command, @argument = user_input
      end

      def execute_new(argument)
        argument = "sinatra-app" if argument.nil?
        parent
        top_level
        public_files
        lib_views
      end

      def app
        case command
        when "new"
          execute_new(argument)
        when "help"
          "Usage:\nnew: sinatra-cl new [APPNAME]"
        else
          "#{command} is not a valid command.\nType 'sinatra-cl help' for more information"
        end
      end

      def parent
        Dir.mkdir(argument)
        Dir.mkdir("#{argument}/lib")
        Dir.mkdir("#{argument}/public")
        Dir.mkdir("#{argument}/views")
        Dir.mkdir("#{argument}/public/css")
        Dir.mkdir("#{argument}/public/img")
        Dir.mkdir("#{argument}/public/js")
      end

      def config
        File.open("#{argument}/config.ru", "w+") { |io|
          io << "require File.join(File.dirname(__FILE__), 'app.rb')\nrun Name::#{argument.capitalize}"
      }
      end


      def top_level

        FileList.new('./assets/*', './assets/.gitignore').each do |path|
          FileUtils.cp(path,"#{argument}/#{path.pathmap("%f")}") unless File.directory?(path)
        end

        config
      end

      def public_files
        FileList.new('./assets/public/**/*.*').each do |path|
          new_path = path.pathmap("%p").split("/").pop(3).unshift("#{argument}").join("/")
          FileUtils.cp(path, new_path)
        end
      end

      def lib_views
        FileList.new('./assets/lib/**/*.*','./assets/views/**/*.*').each do |path|
          new_path = path.pathmap("%p").split("/").pop(2).unshift("#{argument}").join("/")
          FileUtils.cp(path, new_path)
        end
      end

    end
  end
end

s = Sinatra::Cl::Build.new(@input)
s.app
