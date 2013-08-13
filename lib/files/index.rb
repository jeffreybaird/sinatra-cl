module Sinatra
  module Cl
    module Files
      class Index
        def self.build(app_name)
          File.open("#{app_name}/views/index.erb", "w+") { |io|
            io << <<-END
<h1>classy</h1>
<h2>as fuck</h2>
            END
          }
        end
      end
    end
  end
end
