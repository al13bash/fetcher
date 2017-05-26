require 'rails_helper'

describe 'Parsings API' do
  let(:parsed_body) { JSON.parse(response.body) }

  describe 'POST #create' do
    context 'valid params' do
      let(:params) { { parsing: attributes_for(:parsing) } }

      let(:perform_request) do
        post api_v1_parsings_path, params: params
      end

      it 'creates job' do
        expect { perform_request }
          .to have_enqueued_job(ParsingJob)
      end

      it 'creates new parsing' do
        expect { perform_request }.to change { Parsing.count }.by(1)
      end

      it 'creates job' do
        expect { perform_request }
          .to have_enqueued_job(ParsingJob)
      end

      it 'return 200 (success) status code' do
        perform_request
        expect(response.status).to eq(200)
      end

      it 'has pending status' do
        perform_request
        expect(parsed_body['parsing']['status']).to eq('pending')
      end

      it do
        perform_request
        expect(parsed_body['parsing']['url'])
          .to eq(params[:parsing][:url])
      end

      describe 'json structure' do
        before do
          perform_request
        end

        it { expect(parsed_body['parsing']).to have_key('id') }
        it { expect(parsed_body['parsing']).to have_key('created_at') }
        it { expect(parsed_body['parsing']).to have_key('status') }
        it { expect(parsed_body['parsing']).to have_key('url') }
        it { expect(parsed_body['parsing']).to have_key('links') }
        it { expect(parsed_body['parsing']).to have_key('h1') }
        it { expect(parsed_body['parsing']).to have_key('h2') }
        it { expect(parsed_body['parsing']).to have_key('h3') }
      end
    end

    context 'invalid params' do
      let(:params) { { parsing: attributes_for(:parsing, url: nil) } }

      let(:perform_request) do
        post api_v1_parsings_path, params: params
      end

      it 'return 400 status code' do
        perform_request
        expect(response.status).to eq(400)
      end
    end
  end
end
