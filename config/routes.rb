Rails.application.routes.draw do
  resources :journey_maps, only: [:index, :show]
  resources :jira_fields, only: [:show, :create, :update, :destroy]

  root 'journey_maps#index'
end
