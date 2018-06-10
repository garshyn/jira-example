FactoryBot.define do
  factory :field do
    type ""
    contents({})
    association :step
  end

  factory :jira_field, parent: :field, class: 'JiraField' do
    type 'JiraField'
    contents({ 'issue_id' => 1 })
  end
end
