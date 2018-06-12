json.success @field.errors.none?
json.field do
  json.partial! 'fields/field', field: @field
  json.issue @issue
end
