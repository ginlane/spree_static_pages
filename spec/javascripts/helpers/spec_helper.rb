require 'sprockets'
require 'handlebars_assets'
puts "FNORD"
module MustacheRide
  class HandlebarsTemplates < HandlebarsAssets::TiltHandlebars
    include Jasmine::Headless::FileChecker
    def evaluate(*args)
      if bad_format? file
        alert_bad_format file
        return ''
      end
      %{<script type="text/javascript">#{super}</script>}
    end
  end
end

Jasmine::Headless.register_engine ".handlebars", MustacheRide::HandlebarsTemplate
