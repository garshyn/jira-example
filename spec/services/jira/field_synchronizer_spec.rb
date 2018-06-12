require 'rails_helper'

module Jira
  describe Jira::FieldSynchronizer do
    it 'sets cached_at to current time' do
      field = build(:jira_field)
      expect(field.cached_at).to be_nil

      described_class.new(field).call

      expect(field.cached_at).to be_within(1.second).of(Time.current)
    end

    it 'caches response' do
      field = create(:jira_field, contents: { 'issue_id' => '1' })

      described_class.new(field).call

      expect(field.reload.issue).to eq({
        'id' => 1,
        'summary' => 'Issue',
        'description' => 'Description',
      })
    end

    describe '#update' do
      it 'updates a field' do
        field = create(
          :jira_field,
          contents: {
            'issue_id' => '1',
          },
        )
        params = {
          'summary' => 'Edited'
        }

        described_class.new(field).update(params)

        expect(field.reload.issue).to eq({
          'id' => 1,
          'summary' => 'Edited',
          'description' => 'Description',
        })
      end
    end

    describe '#create' do
      it 'creates a field' do
        field = build(
          :jira_field,
        )
        params = {
          'summary' => 'Issue',
          'description' => 'Description',
        }

        expect do
          described_class.new(field).create(params)
        end.to change(Field, :count).by(1)
      end
    end
  end
end
