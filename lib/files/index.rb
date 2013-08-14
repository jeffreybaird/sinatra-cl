module Sinatra
  module Cl
    module Files
      class Index
        def self.build(app_name)
          File.open("#{app_name}/views/index.erb", "w+") { |io|
            io << <<-END
<h1>So. Classy.</h1>
            END
          }
        end
      end
    end
  end
end
