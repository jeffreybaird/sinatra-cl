module Sinatra
  module Cl
    module Files
      class Layout
        def self.build(app_name)
          File.open("#{app_name}/views/layout.erb", "w+") { |io|
            io << <<-END
<!doctype html>
<html>
  <head>
    <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="css/bootstrap-responsive.min.css" type="text/css" rel="stylesheet"/>
  </head>
  <body>
    <div class="container-fluid">
      <%= yield %>
    </div>
    <script src="/js/boostrap.min.js"></script>
  </body>
</html>
            END
          }
        end
      end
    end
  end
end
