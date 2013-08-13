require_relative "app"
require_relative "bootstrap"
require_relative "bootstrap_js"
require_relative "bootstrap_responsive"
require_relative "custom"
require_relative "glyphicons_halflings"
require_relative "glyphicons_halflings_white"
require_relative "gemfile"
require_relative "index"
require_relative "layout"
require_relative "layout_no_bs"
require_relative "model"
require_relative "rakefile"
require_relative "readme"

module Sinatra
  module Cl
    module Files
      class Build

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

        attr_reader :app_name, :flags; private :app_name, :flags
        private

        def no_bootstrap?
          flags.include?(:no_bootstrap)
        end


        def config
          File.open("#{app_name}/config.ru", "w+") { |io|
            io << "require File.join(File.dirname(__FILE__), 'app.rb')\nrun Name::#{app_name.capitalize}"
          }
        end

        def gitignore
          File.open("#{app_name}/.gitignore", "w+") { |io|
            io << ".DS_STORE\n*ds_store\n*.db"
          }
        end

        def top_level

          [Readme, Rakefile, App, Gemfile].each do |const|
            const.build(app_name)
          end

          config
          gitignore
        end

        def public_files
          [Bootstrap,BootstrapResponsive,BootstrapJs,GlyphiconsHalflings,GlyphiconsHalflingsWhite, Custom].each do |const|
            const.build(app_name)
          end
        end

        def view_files_no_bootstrap
          [LayoutNoBs,Index].each do |const|
            const.build(app_name)
          end
        end

        def lib_files
          [Model].each do |const|
            const.build(app_name)
          end
        end

        def view_files
          [Layout,Index].each do |const|
            const.build(app_name)
          end
        end
      end
    end
  end
end
