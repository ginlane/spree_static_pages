module SpreeStaticPages
  class Engine < Rails::Engine
    require 'spree/core'
    require 'ember-rails'
    isolate_namespace Spree
    engine_name 'spree_static_pages'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    # config.ember.app_name = "SpreeStaticPages"
    config.handlebars.templates_root = "admin/spree_static_pages/templates"

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
