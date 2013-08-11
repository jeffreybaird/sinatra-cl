module Sinatra
  module Cl
    module Files
      class Gemfile
        def self.build(app_name)
          File.open("#{app_name}/config.ru", "w+") { |io|
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
        end
      end
    end
  end
end
