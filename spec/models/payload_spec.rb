require 'rails_helper'

RSpec.describe Payload do
  let!(:payload) { create(:payload_with_parsing) }

  it 'has a valid factory' do
    expect(payload).to be_valid
  end

  it { should belong_to(:parsing) }
  it { should define_enum_for(:kind) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:content) }
end
