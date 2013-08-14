require_relative "app"
require_relative "bootstrap/bootstrap"
require_relative "bootstrap/bootstrap_js"
require_relative "bootstrap/bootstrap_responsive"
require_relative "bootstrap/custom"
require_relative "bootstrap/glyphicons_halflings"
require_relative "bootstrap/glyphicons_halflings_white"
require_relative "gemfile"
require_relative "index"
require_relative "bootstrap/layout"
require_relative "no-bootstrap/layout_no_bs"
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
          no_bootstrap? ? no_bootstrap_files : boostrap_files
        end

        attr_reader :app_name, :flags; private :app_name, :flags
        private

        def no_bootstrap?
          flags.include?(:no_bootstrap)
        end

        def top_level

          [App,Gemfile,Index,Model,Rakefile,Readme].each do |const|
            const.build(app_name)
          end

          config
          gitignore
        end


        def no_bootstrap_files
          [LayoutNoBs].each do |const|
            const.build(app_name)
          end
        end

        def boostrap_files
          [Bootstrap, BootstrapJs,BootstrapResponsive,Custom,GlyphiconsHalflings,GlyphiconsHalflingsWhite,Layout].each do |const|
            const.build(app_name)
          end
        end

        def config
          File.open("#{app_name}/config.ru", "w+") { |io|
            io << "require File.join(File.dirname(__FILE__), 'app.rb')\nrun #{app_name.capitalize}::App"
          }
        end

        def gitignore
          File.open("#{app_name}/.gitignore", "w+") { |io|
            io << ".DS_STORE\n*ds_store\n*.db"
          }
        end

      end
    end
  end
end
