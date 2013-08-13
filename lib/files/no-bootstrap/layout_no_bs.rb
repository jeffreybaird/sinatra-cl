module Sinatra
  module Cl
    module Files
      class LayoutNoBs
        def self.build(app_name)
          File.open("#{app_name}/views/layout.erb", "w+") { |io|
            io << <<-END
<!doctype html>
<html>
  <head>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
            END
          }
        end
      end
    end
  end
end
