require 'rails_helper'

describe 'API' do
  describe 'journey map' do
    it 'returns steps' do
      time = Time.current.strftime('%Y-%m-%d %H:%M:%S')
      journey_map = create :journey_map, title: 'Title 1'
      step_1 = create(
        :step,
        journey_map: journey_map,
        title: 'Step 1',
      )
      step_1.fields.create([
        {
          type: 'JiraField',
          contents: {
            'issue_id' => 1,
          },
        },
        {
          type: 'JiraField',
          contents: {
            'issue_id' => 2,
            # 'cached_at' => time,
            # 'issue' => {
            #   'summary' => 'Issue',
            # }
          },
        },
      ])
      step_2 = create(
        :step,
        journey_map: journey_map,
        title: 'Step 2',
      )

      get journey_map_path(id: journey_map.id, format: :json)

      expect(json['success']).to be true
      expect(json['journey_map']['title']).to eq 'Title 1'
      expect(json['journey_map']['steps'].size).to eq 2
      expect(json['journey_map']['steps'].first['title']).to eq 'Step 1'
      expect(json['journey_map']['steps'].first['fields'].size).to eq 2
      field = step_1.fields.first
      expect(json['journey_map']['steps'].first['fields'].first).to eq({
        'id' => field.id,
        'type' => 'JiraField',
        'contents' => {
          'issue_id' => 1,
        },
        'step_id' => step_1.id,
        'cmp' => 'jira-field',
        'has_to_sync' => true,
        'url' => jira_field_path(field),
        'errors' => [],
      })

      field_2 = step_1.fields.second
      expect(json['journey_map']['steps'].first['fields'].second).to eq({
        'id' => field_2.id,
        'type' => 'JiraField',
        'contents' => {
          'issue_id' => 2,
        },
        'step_id' => step_1.id,
        'cmp' => 'jira-field',
        'has_to_sync' => true,
        'url' => jira_field_path(field_2),
        'errors' => [],
      })
    end
  end
end
