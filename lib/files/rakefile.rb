module Sinatra
  module Cl
    module Files
      class Rakefile
        def self.build(app_name)
          File.open("#{app_name}/Rakefile", "w+") { |io|
            io << <<-END
require "./app"
require "sinatra/activerecord/rake"
            END
          }
        end
      end
    end
  end
end
