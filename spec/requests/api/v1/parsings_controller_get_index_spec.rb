require 'rails_helper'

describe 'Parsings API' do
  let(:parsed_body) { JSON.parse(response.body) }
  let(:parsed_parsings_ids) do
    parsed_body['parsings']
      .map { |h| h['parsing'] }
      .map { |parsing| parsing['id'] }
  end

  let(:first_parsed_parsing) { parsed_body['parsings'].first['parsing'] }

  describe 'GET #index' do
    let!(:parsings) do
      create_list(:parsing, 3, status: :completed)
        .concat(create_list(:parsing, 3, status: :pending))
        .concat(create_list(:parsing, 3, status: :failed))
    end

    let(:required_parsings) do
      parsings.select(&:completed?)
              .first(params[:per_page])
              .sort_by(&:created_at)
              .reverse
    end

    let(:params) { { page: 1, per_page: 5 } }

    before do
      get api_v1_parsings_path, params: params
    end

    it 'return 200 (success) status code' do
      expect(response.status).to eq(200)
    end

    it 'returns completed parsings' do
      expect(parsed_body['parsings'].length)
        .to eq(required_parsings.pluck(:completed).length)
    end

    it 'returns parsings per page' do
      expect(parsed_body['parsings'].length)
        .to be <= params[:per_page]
    end

    it 'returns ordered parsings' do
      expect(parsed_parsings_ids)
        .to eq(required_parsings.pluck(:id))
    end

    describe 'json structure' do
      it { expect(parsed_body).to have_key('current_page') }
      it { expect(parsed_body).to have_key('total_pages') }
      it { expect(parsed_body).to have_key('total_count') }
      it { expect(parsed_body).to have_key('per_page_count') }
      it { expect(parsed_body['parsings'].first).to have_key('parsing') }
      it { expect(first_parsed_parsing).to have_key('id') }
      it { expect(first_parsed_parsing).to have_key('created_at') }
      it { expect(first_parsed_parsing).to have_key('status') }
      it { expect(first_parsed_parsing).to have_key('url') }
    end
  end
end
