module Sinatra
  module Cl
    class Directory

      attr_reader :app_name, :flags

      def initialize(app_name, flags)
        @app_name = app_name
        @flags = flags
      end

      def build
        parent
      end

      def parent
        Dir.mkdir(app_name)
        Dir.mkdir("#{app_name}/lib")
        Dir.mkdir("#{app_name}/public")
        Dir.mkdir("#{app_name}/views")
        Dir.mkdir("#{app_name}/public/css")
        Dir.mkdir("#{app_name}/public/img")
        Dir.mkdir("#{app_name}/public/js")
      end

    end
  end
end
