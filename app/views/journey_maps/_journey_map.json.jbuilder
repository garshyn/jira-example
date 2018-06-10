json.title journey_map.title
json.steps do
  json.array! journey_map.steps.includes(:fields), partial: 'steps/step', as: :step
end
