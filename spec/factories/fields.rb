FactoryBot.define do
  factory :field do
    type ""
    contents({})
    association :step
  end
end
