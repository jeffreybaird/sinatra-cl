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

          file_constant_generator.each do |const|
            const.build(app_name)
          end

          config
          gitignore
        end


        def no_bootstrap_files
          no_bootstrap_file_constant_generator.each do |const|
            const.build(app_name)
          end
        end

        def boostrap_files
          boostrap_file_constant_generator.each do |const|
            const.build(app_name)
          end
        end

        def file_constant_generator
          FileList.new("./lib/files/*.rb").map do |file|
            const = my_constantize("Sinatra::Cl::Files::" << file.pathmap("%n").split("_").map{|x| x.capitalize}.join(""))
            const unless const == Build
          end.compact
        end

        def boostrap_file_constant_generator
          FileList.new("./lib/files/bootstrap/*.rb").map do |file|
            my_constantize("Sinatra::Cl::Files::" << file.pathmap("%n").split("_").map{|x| x.capitalize}.join(""))
          end
        end

        def no_bootstrap_file_constant_generator
          FileList.new("./lib/files/no-boostrap/*.rb").map do |file|
            my_constantize("Sinatra::Cl::Files::" << file.pathmap("%n").split("_").map{|x| x.capitalize}.join(""))
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

        def my_constantize(class_name)
          unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ class_name
            raise NameError, "#{class_name.inspect} is not a valid constant name!"
          end

          Object.module_eval("::#{$1}", __FILE__, __LINE__)
        end

      end
    end
  end
end
