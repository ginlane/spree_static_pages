# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_static_pages'
  s.version     = '0.1'
  s.summary     = 'Static pages for Spree'
  s.description = "Static! Static! We're livin' in a video age!"
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Gin Lane'
  s.email     = 'scotty@ginlanemedia.com'


  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'


  s.add_dependency 'spree'
  s.add_dependency 'haml-rails'
  s.add_dependency 'redcarpet'
  s.add_dependency 'ruby-oembed', '~>0.8.9'
  s.add_dependency 'ember-rails'
  s.add_dependency 'ember-source', '~>1.2.0'
  s.add_dependency 'handlebars-source', '~>1.1.2'
  #s.add_dependency 'emblem-rails'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'

end
