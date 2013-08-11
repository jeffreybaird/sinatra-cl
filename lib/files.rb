module Sinatra
  module Cl
    class Files

      attr_reader :app_name, :flags

      def initialize(app_name, flags)
        @app_name = app_name
        @flags = flags
      end

      def build
        top_level
        lib_files
        public_files unless no_bootstrap?
        no_bootstrap? ? view_files_no_bootstrap : view_files
      end

      def config
        File.open("#{app_name}/config.ru", "w+") { |io|
          io << "require File.join(File.dirname(__FILE__), 'app.rb')\nrun Name::#{app_name.capitalize}"
      }
      end

      def no_bootstrap?
        flags.include?(:no_bootstrap)
      end


      def top_level

        FileList.new('./assets/*', './assets/.gitignore').each do |path|
          FileUtils.cp(path,"#{app_name}/#{path.pathmap("%f")}") unless File.directory?(path)
        end

        config
      end

      def public_files
        FileList.new('./assets/public/**/*.*').each do |path|
          new_path = path.pathmap("%p").split("/").pop(3).unshift("#{app_name}").join("/")
          FileUtils.cp(path, new_path)
        end
      end

      def view_files_no_bootstrap
        FileList.new('./assets/views_no_bootstrap/**/*.*').each do |path|
          new_path = path.pathmap("%p").split("/").pop(1).unshift("#{app_name}","views").join("/")
          FileUtils.cp(path, new_path)
        end
      end

      def lib_files
        FileList.new('./assets/lib/**/*.*').each do |path|
          new_path = path.pathmap("%p").split("/").pop(2).unshift("#{app_name}").join("/")
          FileUtils.cp(path, new_path)
        end
      end

      def view_files
        FileList.new('./assets/views/**/*.*').each do |path|
          new_path = path.pathmap("%p").split("/").pop(2).unshift("#{app_name}").join("/")
          FileUtils.cp(path, new_path)
        end
      end

    end
  end
end