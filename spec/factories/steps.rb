FactoryBot.define do
  factory :step do
    sequence(:title) { |n| "Step #{n}" }
    description "MyText"
    association :journey_map
  end
end
