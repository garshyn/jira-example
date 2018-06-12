class JiraFieldsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @field = JiraField.find params[:id]
    @issue = Jira::FieldSynchronizer.new(@field).call.contents['issue']
    render 'fields/show'
  end

  def create
    @field = Jira::FieldSynchronizer.new(JiraField.new step_id: field_params[:step_id]).create(issue_params)
    render 'fields/show'
  end

  def update
    field_to_sync = JiraField.find params[:id]
    @field = Jira::FieldSynchronizer.new(field_to_sync).update(field_params)
    render 'fields/show'
  end

  def destroy
    field = JiraField.find params[:id]
    field.destroy
    render json: { success: true }
  end

  private

  def field_params
    params.require(:field).permit(
      :step_id,
      :summary,
      :description,
    )
  end

  def issue_params
    field_params.slice(:summary, :description)
  end
end
