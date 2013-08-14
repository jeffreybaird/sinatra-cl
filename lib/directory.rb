module Sinatra
  module Cl
    class Directory

      def initialize(app_name)
        @app_name = app_name
      end

      def build
        parent
      end

      attr_reader :app_name; private :app_name
      private

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
