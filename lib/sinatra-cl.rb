require_relative "sinatra-cl/version"
require 'rake'
require 'fileutils'

module Sinatra
  module Cl
    class Generate
      attr_reader :command, :argument

      def initialize(user_input)
        @command, @argument = user_input
      end

      def execute_new(argument)
        argument = "sinatra-app" if argument.nil?
        build_parent
        build_gem_file
        build_gitignore
        build_readme
        build_rakefile
        build_apprb
        build_config
        build_model
        build_css
        build_img
        build_js
        build_erb
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

      def build_parent
        Dir.mkdir(argument)
        Dir.mkdir("#{argument}/lib")
        Dir.mkdir("#{argument}/public")
        Dir.mkdir("#{argument}/views")
        Dir.mkdir("#{argument}/public/css")
        Dir.mkdir("#{argument}/public/img")
        Dir.mkdir("#{argument}/public/js")
      end

      def build_gem_file
        File.open("#{argument}/GEMFILE", "w+") { |io|
          io << <<-END
source "https://rubygems.org"


gem "sinatra"
gem "sqlite3"
gem "activerecord"
gem "sinatra-activerecord"
gem "rake"

group :development do
  gem "shotgun"
  gem "tux"
end
          END
           }
      end

      def build_gitignore
        File.open("#{argument}/.gitignore", "w+") { |io|
          io << <<-END
.DS_STORE
*ds_store
*.db
        END
        }
      end

      def build_readme
        File.open("#{argument}/README.md", "w+") { |io|
          io << <<-END
#ratpack

a simple boilerplate for creating production-ready sinatra apps that use activerecord and sqlite

twitterbootstrap using html and css are included.

if ya want haml and sass, be on the look for classy.

## Up and running
1. `bundle install`
2. `shotgun`
3. visit `localhost:9393`

## Gemfile
- [sinatra](http://www.sinatrarb.com/): web framework
- [sqlite3](https://github.com/luislavena/sqlite3-ruby): Database
- [activerecord](http://guides.rubyonrails.org/active_record_querying.html): ORM
- [sinatra-activerecord](https://github.com/bmizerany/sinatra-activerecord)
- [rake](http://rake.rubyforge.org/)

### Development
   * [shotgun](https://github.com/rtomayko/shotgun)
   * [tux](http://tagaholic.me/2011/04/10/tux-a-sinatra-console.html)
      END
    }
      end

      def build_rakefile
        File.open("#{argument}/Rakefile", "w+") { |io|
          io << <<-END
require "./app"
require "sinatra/activerecord/rake"
          END
          }
      end

      def build_apprb
        File.open("#{argument}/app.rb", "w+") { |io|
          io << <<-END
require 'bundler'
Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Name
  class App < Sinatra::Application

    #configure
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    #database
    set :database, "sqlite3:///#{argument}.db"

    #filters

    #routes
    get '/' do
      erb :index
    end

    #helpers
    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
    end

  end
end
          END
        }
      end

      def build_config
        File.open("#{argument}/config.ru", "w+") { |io|
          io << <<-END
require File.join(File.dirname(__FILE__), 'app.rb')

run Name::App
        END
      }
      end

      def build_model
        File.open("#{argument}/lib/model.rb", "w+") { |io|
          io << <<-END
class Model < ActiveRecord::Base

end
        END
        }
      end

      def build_css
        FileList.new('./assets/*.css').each do |path|
          FileUtils.cp(path,"#{argument}/public/css/#{path.pathmap("%f")}")
        end
      end

      def build_img
        FileList.new('./assets/*.png','./assets/*.jpg').each do |path|
          FileUtils.cp(path,"#{argument}/public/img/#{path.pathmap("%f")}")
        end
      end

      def build_js
        FileList.new('./assets/*.js').each do |path|
          FileUtils.cp(path,"#{argument}/public/js/#{path.pathmap("%f")}")
        end
      end

      def build_erb
        FileList.new('./assets/*.erb').each do |path|
          FileUtils.cp(path,"#{argument}/views/#{path.pathmap("%f")}")
        end
      end

    end
  end
end

s = Sinatra::Cl::Generate.new(@input)
s.build_app
