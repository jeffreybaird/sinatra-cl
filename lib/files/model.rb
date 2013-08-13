module Sinatra
  module Cl
    module Files
      class Model
        def self.build(app_name)
          File.open("#{app_name}/lib/model.rb", "w+") { |io|
            io << <<-END
class Model < ActiveRecord::Base

end
            END
          }
        end
      end
    end
  end
end
