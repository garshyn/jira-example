json.title step.title
json.fields do
  json.array! step.fields, partial: 'fields/field', as: :field
end
