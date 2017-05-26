require 'rails_helper'

RSpec.describe NotificationJobs::SuccessParsing do
  let!(:parsing) { create(:parsing) }
  subject(:job) { described_class.perform_later(key) }
  let(:perform) { described_class.new.perform(key) }

  let(:key) { parsing.id }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
      .with(key)
      .on_queue('default')
  end

  it 'RestClient patch' do
    expect(RestClient).to receive(:patch)
    perform
  end
end
