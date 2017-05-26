require 'rails_helper'

RSpec.describe Parsing do
  let!(:parsing) { create(:parsing) }

  it 'has a valid factory' do
    expect(parsing).to be_valid
  end

  it { should have_many(:payloads) }
  it { should define_enum_for(:status) }
  it { should validate_presence_of(:url) }
  it { should allow_value('http://example.com').for(:url) }
  it do
    should allow_value('http://example.com/success')
      .for(:success_callback_url)
  end
  it do
    should allow_value('http://example.com/failure')
      .for(:failure_callback_url)
  end
  it { should_not allow_value('example.com').for(:url) }
  it do
    should_not allow_value('example.com/success')
      .for(:success_callback_url)
  end
  it do
    should_not allow_value('example.com/failure')
      .for(:failure_callback_url)
  end
end
