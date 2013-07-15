TocartaAdmin::Application.configure do
  
  # Defined in config/application.yml
  # ENV['S3_BUCKET'] ||= 'tocarta-prod'
  # ENV['S3_KEY'] ||= 'AKIAJCY5PI67O7THQ5MQ'
  # ENV['S3_SECRET'] ||= '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'
  
  # ENV['NODE_SERVER'] ||= 'http://tocarta-node.herokuapp.com'
  
  # ENV['MONGOHQ_URL'] ||= 'mongodb://tocarta:tocarta@dharma.mongohq.com:10007/Analytics'
  
  Paperclip::Attachment.default_options.merge!({
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  })
  
  # Setting up Pusher in production
  # Pusher.app_id = '4915'
  # Pusher.key    = 'd20cf40b86a0639e33cc'
  # Pusher.secret = 'f13b3a335cc5627caacc'
  
  # Defined in config/application.yml
  # Pusher.app_id = '17051'
  # Pusher.key    = '7eb8d4a46b4a183f76e7'
  # Pusher.secret = 'c5f0ad3864787f78d53f'
  
  # Settings specified here will take precedence over those in config/application.rb

  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { :host => 'tocarta.es' }
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

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )
  config.assets.precompile += %w( rails_admin/tocarta_admin.css dashboards/application-ie.css dashboards/chartkick-tocarta.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
end
