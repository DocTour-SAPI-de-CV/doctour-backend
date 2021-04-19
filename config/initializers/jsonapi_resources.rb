JSONAPI.configure do |config|
  # para usar key integers e uuid
  config.resource_key_type = ->(key, context) { key && String(key) }
end
