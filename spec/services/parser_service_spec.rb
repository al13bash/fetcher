require 'rails_helper'

RSpec.describe ParserService do
  let!(:parsing) { create(:parsing) }
  let(:service) { ParserService.new(parsing: parsing) }

  describe 'run!' do
    before do
      service.run!
    end

    it 'creates payloads' do
      expect(parsing.payloads.count).to eq(8)
    end

    it 'makes parsing status to completed' do
      expect(parsing.reload.status).to eq('completed')
    end
  end
end
