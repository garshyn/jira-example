require 'rails_helper'

describe JiraField do
  describe 'validation' do
    it 'has a valid factory' do
      expect(build(:jira_field)).to be_valid
    end

    it 'is invalid without an id' do
      field = build(
        :jira_field,
        contents: {},
      )
      expect(field).not_to be_valid
    end
  end

  describe 'cache' do
    context 'with cached_at' do
      it 'is cached' do
        field = build(
          :jira_field,
          contents: {
            'cached_at' => 1.hour.ago,
          },
        )

        expect(field).to be_cached
      end

      context 'too old' do
        it 'has to be synced' do
          field = build(
            :jira_field,
            contents: {
              'cached_at' => 1.hour.ago,
            },
          )

          expect(field).to have_to_sync
        end
      end

      context 'not too old' do
        it 'has to be synced' do
          field = build(
            :jira_field,
            contents: {
              'cached_at' => Time.current,
            },
          )

          expect(field).not_to have_to_sync
        end
      end
    end

    context 'without cached_at' do
      it 'is not cached' do
        field = build(
          :jira_field,
          contents: {},
        )

        expect(field).not_to be_cached
      end

      it 'has to be synced' do
        field = build(
          :jira_field,
          contents: {},
        )

        expect(field).to have_to_sync
      end
    end

    describe '#cached_ago' do
      context 'with cached_at' do
        it 'shows time after last cached' do
          field = build(
            :jira_field,
            contents: {
              'cached_at' => 10.seconds.ago,
            }
          )

          expect(field.cached_ago).to eq '10 seconds ago'
        end

        it 'says now' do
          field = build(
            :jira_field,
            contents: {
              'cached_at' => Time.current,
            }
          )

          expect(field.cached_ago).to eq 'now'
        end
      end

      context 'witout cached_at' do
        it 'says never' do
          field = build :jira_field

          expect(field.cached_ago).to eq 'never'
        end
      end
    end
  end
end
