require 'rails_helper'

describe 'Parsings API' do
  let(:parsed_body) { JSON.parse(response.body) }

  describe 'GET #show' do
    let!(:parsing) { create(:parsing, :with_payloads) }

    before do
      get api_v1_parsing_path(id: parsing.id)
    end

    it 'return 200 (success) status code' do
      expect(response).to be_success
    end

    it { expect(parsed_body['parsing']['id']).to eq(parsing.id) }
    it { expect(parsed_body['parsing']['status']).to eq(parsing.status) }
    it { expect(parsed_body['parsing']['url']).to eq(parsing.url) }

    it do
      expect(parsed_body['parsing']['links'])
        .to eq(parsing.payloads.link
                 .map { |payload| { 'content' => payload.content } })
    end

    it do
      expect(parsed_body['parsing']['h1'])
        .to eq(parsing.payloads.h1
                 .map { |payload| { 'content' => payload.content } })
    end

    it do
      expect(parsed_body['parsing']['h2'])
        .to eq(parsing.payloads.h2
                 .map { |payload| { 'content' => payload.content } })
    end

    it do
      expect(parsed_body['parsing']['h3'])
        .to eq(parsing.payloads.h3
                 .map { |payload| { 'content' => payload.content } })
    end

    describe 'json structure' do
      it { expect(parsed_body['parsing']).to have_key('h1') }
      it { expect(parsed_body['parsing']).to have_key('h2') }
      it { expect(parsed_body['parsing']).to have_key('h3') }
      it { expect(parsed_body['parsing']).to have_key('links') }
    end
  end
end
