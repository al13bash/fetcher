FactoryGirl.define do
  factory :payload do
    kind Payload.kinds.values.sample
    content 'Sample content'

    factory :payload_with_parsing do
      parsing
    end
  end
end
