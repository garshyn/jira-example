module Jira
  class FieldSynchronizer
    attr_reader :field, :client

    def initialize(field)
      @field = field

      options = Rails.application.secrets[:jira][:connection].merge(
        auth_type: :basic
      )

      @client ||= JIRA::Client.new(options)
    end

    def call
      field.tap do |f|
        response = client.Issue.find(field.contents['issue_id'].to_i)
        f.contents['issue'] = response.attrs['fields']
        f.contents['cached_at'] = Time.current
        f.save!
      end
    end

    def update(params)
      field.tap do |f|
        issue = client.Issue.find(field.contents['issue_id'].to_i)
        response = issue.save("fields" => params)
        if response == false
          f.errors.add :contents
          next
        end
        f.contents['issue'] = issue.attrs['fields']
        f.contents['cached_at'] = Time.current
        f.contents['response'] = response
        f.save!
      end
    end

    def create(params)
      create_params = params.merge(
        'project' => {
          'id' => '10001',
        },
        'issuetype' => {
          'id' => '10003',
        },
      )
      field.tap do |f|
        issue = client.Issue.build
        issue.save("fields" => create_params)
        issue.fetch
        f.contents = {
          'issue_id' => issue.id,
          'issue' => issue.attrs['fields'],
          'cached_at' => Time.current,
        }
        f.save!
      end
    end
  end
end
