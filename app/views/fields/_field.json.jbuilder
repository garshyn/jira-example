json.extract! field, :id, :type, :contents, :step_id
json.cmp field.type.underscore.dasherize
json.partial! "fields/#{field.type.underscore}", field: field
json.errors field.errors.full_messages
