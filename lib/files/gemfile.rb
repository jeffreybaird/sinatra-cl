module Sinatra
  module Cl
    module Files
      class Gemfile
        def self.build(app_name)
          File.open("#{app_name}/config.ru", "w+") { |io|
            io <<
        end
      end
    end
  end
end
