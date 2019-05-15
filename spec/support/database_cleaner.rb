# frozen_string_literal: true

require 'database_cleaner'

RSpec.configure do |config|
  config.before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
