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
  end
end
