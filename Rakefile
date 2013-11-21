require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'spree/testing_support/extension_rake'

RSpec::Core::RakeTask.new

task :default => [:spec]

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'spree_static_pages'
  Rake::Task['extension:test_app'].invoke
  sh "bundle exec rails g spree:install -auto-accept --force"
  sh "bundle exec rails g spree_static_pages:install --auto-accept --auto-run-migrations"
end
