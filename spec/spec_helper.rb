require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
  add_filter 'app/admin'
end

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
