TocartaAdmin::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  
  # ENV['S3_BUCKET'] ||= 'tocarta-test'
  # ENV['S3_KEY'] ||= 'AKIAJCY5PI67O7THQ5MQ'
  # ENV['S3_SECRET'] ||= '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'
  ENV['S3_BUCKET'] ||= 'tocarta-prod'
  ENV['S3_KEY'] ||= 'AKIAJCY5PI67O7THQ5MQ'
  ENV['S3_SECRET'] ||= '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'
  
  ENV['NODE_SERVER'] ||= 'http://localhost:5000'
  
  
  # Setting up Paperclip
  Paperclip::Attachment.default_options.merge!({
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  })
  
  # Setting up Pusher in development
  Pusher.app_id = '17050'
  Pusher.key    = 'c9c649f5255c17685066'
  Pusher.secret = '02fbd38ac9ef7d72457e'

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log
  
  config.log_level = :debug
  
  # config.serve_static_assets = true

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = false

  # reload file sin lib when changed
  config.watchable_dirs['lib'] = [:rb]
end
