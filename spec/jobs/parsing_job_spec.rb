require 'rails_helper'

RSpec.describe ParsingJob do
  let!(:parsing) { create(:parsing) }
  subject(:job) { described_class.perform_later(key) }

  let(:key) { parsing.id }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
      .with(key)
      .on_queue('parsing')
  end

  describe 'perform' do
    let(:perform) { described_class.new.perform(key) }

    it 'calls ParserService' do
      expect(ParserService)
        .to receive(:new).with(parsing: parsing)
        .and_return(ParserService.new(parsing: parsing))
      perform
    end

    context 'ParserService raises an error' do
      before do
        expect_any_instance_of(ParserService)
          .to receive(:run!)
          .and_raise(ActiveRecord::Rollback)
      end

      it 'calls NotificationJobs::FailedParsing' do
        expect(NotificationJobs::FailedParsing).to receive(:perform_later)
      end

      after do
        expect { perform }
          .to raise_error(ActiveRecord::Rollback)
      end
    end

    context "ParserService's done successfully" do
      before do
        expect_any_instance_of(ParserService)
          .to receive(:run!)
          .and_return(true)
      end

      it 'calls NotificationJobs::SuccessParsing' do
        expect(NotificationJobs::SuccessParsing).to receive(:perform_later)
        perform
      end
    end
  end
end
