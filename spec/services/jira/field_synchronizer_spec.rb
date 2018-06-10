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
  end
end
