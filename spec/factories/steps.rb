FactoryBot.define do
  factory :step do
    sequence(:title) { |n| "Step #{n}" }
    description "MyText"
    association :journey_map
  end

  factory :jira_field, parent: :field, class: 'JiraField' do
    contents({ 'issue_id' => 1 })
  end
end
