require 'rails_helper'

RSpec.describe NotificationJobs::FailedParsing do
  let!(:parsing) { create(:parsing) }
  subject(:job) { described_class.perform_later(key, message) }
  let(:perform) { described_class.new.perform(key, message) }

  let(:key) { parsing.id }
  let(:message) { 'message' }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
      .with(key, message)
      .on_queue('default')
  end

  it 'RestClient patch' do
    expect(RestClient).to receive(:patch)
    perform
  end
end
