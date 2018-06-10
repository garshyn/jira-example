Rails.application.routes.draw do
  resources :journey_maps, only: [:index, :show]
  resources :jira_fields, only: [:show]

  root 'journey_maps#index'
end
