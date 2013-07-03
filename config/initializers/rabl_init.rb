Rabl.configure do |config|
  config.include_json_root     = false
  config.enable_json_callbacks = true
  config.include_json_root     = false
  config.include_child_root    = false

  config.cache_all_output = Rails.env.production?
  config.cache_sources    = Rails.env.production?
  config.view_paths       = [Rails.root.join('app/views')]

  # Commented as these are defaults
  # config.json_engine = nil # Any multi\_json engines
  # config.msgpack_engine = nil # Defaults to ::MessagePack
  # config.bson_engine = nil # Defaults to ::BSON
  # config.plist_engine = nil # Defaults to ::Plist::Emit
  # config.include_msgpack_root = true
  # config.include_bson_root = true
  # config.include_plist_root = true
  # config.include_xml_root  = false
  # config.xml_options = { :dasherize  => true, :skip_types => false }
end
