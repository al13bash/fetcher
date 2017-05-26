# frozen_string_literal: true

require 'factory_girl_rails'
require 'rspec/active_job'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include RSpec::ActiveJob

  config.before(:each) do
    stub_request(:get, 'http://example.com')
      .to_return(status: 200,
                 body: File.new(fixture_path + '/' + 'rails.html'),
                 headers: {})

    stub_request(:patch, 'http://example.com/')
    stub_request(:patch, 'http://example.com/failure')
    stub_request(:patch, 'http://example.com/success')
  end

  config.after(:each) do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
    ActiveJob::Base.queue_adapter.performed_jobs = []
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
