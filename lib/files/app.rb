module Sinatra
  module Cl
    module Files
      class App
        def self.build(app_name)
          File.open("#{app_name}/app.rb", "w+") { |io|
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
    set :database, "sqlite3:///#{app_name}.db"

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
      end
    end
  end
end
