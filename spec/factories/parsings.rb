FactoryGirl.define do
  factory :parsing do
    status Parsing.statuses.values.sample
    url 'http://example.com'
    success_callback_url 'http://example.com/success'
    failure_callback_url 'http://example.com/failure'

    trait :with_payloads do
      after(:create) do |parsing|
        [create(:payload, parsing: parsing, kind: :h1),
         create(:payload, parsing: parsing, kind: :h2),
         create(:payload, parsing: parsing, kind: :h3),
         create(:payload, parsing: parsing, kind: :link)]
      end
    end
  end
end
