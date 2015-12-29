require 'simplecov'
SimpleCov.start do
  SimpleCov.minimum_coverage 100
end

require 'rack/test'
# Module to mixin ract test
module RSpecMixin
  include Rack::Test::Methods
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

require_relative '../lib/journey_walker_web'
