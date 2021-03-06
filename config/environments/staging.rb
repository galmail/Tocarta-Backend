TocartaAdmin::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Defined in config/application.yml
  # ENV['S3_BUCKET'] ||= 'tocarta-test'
  # ENV['S3_KEY'] ||= 'AKIAJCY5PI67O7THQ5MQ'
  # ENV['S3_SECRET'] ||= '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'

  # ENV['NODE_SERVER'] ||= 'http://tocarta-node-staging.herokuapp.com'

  # Setting up Paperclip
  Paperclip::Attachment.default_options.merge!({
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  })

  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { :host => 'beta.tocarta.es' }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :user_name => ENV['SMTP_USER'],
    :password => ENV['SMTP_PASS'],
    :address => ENV['SMTP_ADDRESS'],
    :port => ENV['SMTP_PORT'],
    :authentication => ENV['SMTP_AUTH'],
    :domain => ENV['SMTP_DOMAIN'],
    :enable_starttls_auto => true
  }

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = true
  config.assets.compile = false
  config.assets.digest = true

  # Expands the lines which load the assets
  config.assets.debug = true

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w( rails_admin/tocarta_admin.css dashboards/application-ie.css dashboards/chartkick-tocarta.js )

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

end
