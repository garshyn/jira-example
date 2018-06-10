class JiraFieldsController < ApplicationController
  def show
    field_to_sync = JiraField.find params[:id]
    @field = Jira::FieldSynchronizer.new(field_to_sync).call
    render 'fields/show'
  end
end
