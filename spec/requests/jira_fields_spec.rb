require 'rails_helper'

describe 'API' do
  describe 'jira field' do
    it 'returns data' do
      field = create(
        :jira_field,
      )

      get jira_field_path(field, format: :json)

      expect(json['field']['issue']).to eq({
        'id' => 1,
        'summary' => 'Issue',
        'description' => 'Description'
      })
    end

    it 'updates a field' do
      field = create(
        :jira_field,
      )

      params = {
        field: {
          summary: 'Edited'
        }
      }

      patch jira_field_path(field, format: :json), params: params

      expect(json['field']['contents']['issue']).to eq({
        "id" => 1,
        "summary" => "Edited",
        "description" => "Description",
      })
    end

    describe 'create' do
      it 'creates a field' do
        step = create :step
        params = {
          field: {
            step_id: step.id,
            summary: 'Issue',
            description: 'Description',
          }
        }

        allow_any_instance_of(Jira::FieldSynchronizer).to receive(:create) { create(:jira_field) }

        expect do
          post jira_fields_path(format: :json), params: params
        end.to change(Field, :count).by(1)
      end
    end
  end
end
