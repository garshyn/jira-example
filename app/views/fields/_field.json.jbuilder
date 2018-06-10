json.extract! field, :type, :contents
json.cmp field.type.underscore.dasherize
json.partial! "fields/#{field.type.underscore}", field: field
