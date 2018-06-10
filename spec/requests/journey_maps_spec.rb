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
            'cached_at' => time,
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
      expect(json['journey_map']['steps'].first['fields'].first).to eq({
        'type' => 'JiraField',
        'contents' => {
          'issue_id' => 1,
        },
        'cmp' => 'jira-field',
        'has_to_sync' => true,
        'url' => jira_field_path(step_1.fields.first),
        'cached_ago' => 'never',
      })
    end
  end
end
