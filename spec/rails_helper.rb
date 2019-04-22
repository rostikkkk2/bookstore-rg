require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara/rails'
require 'selenium-webdriver'
require 'rack_session_access/capybara'
require 'devise'
require 'cancan/matchers'
require 'yaml'
require 'i18n'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryBot::Syntax::Methods
  config.include Warden::Test::Helpers
  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include Shoulda::Matchers::ActionController
  config.extend ControllerMacros, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.use_transactional_fixtures = true
  Capybara.default_driver = :selenium_chrome

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
