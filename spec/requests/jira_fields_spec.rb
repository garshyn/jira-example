require 'rails_helper'

describe 'API' do
  describe 'jira field' do
    it 'calls JIRA API and returns updated record' do
      field = create(
        :jira_field,
      )

      get jira_field_path(field, format: :json)
      expect(json['field']['contents']['issue']).to eq({
        "id" => 1,
        "summary" => "Issue",
        "description" => "Description"
      })
    end
  end
end
