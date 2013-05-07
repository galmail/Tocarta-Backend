require 'faraday'

module Onceocho
  # Defines constants and methods related to configuration
  module  Configuration
    # An array of valid keys in the options hash
    VALID_OPTIONS_KEYS = [
      :logger,
      :adapter,
      :app_key,
      :secret_key,
      :session_token,
      :base,
      :url
    ].freeze

    DEFAULT_LOGGER  = nil
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default everithing is nil
    DEFAULT_APP_KEY       = nil
    DEFAULT_SECRET_KEY    = nil
    DEFAULT_SESSION_TOKEN = nil

    # Default endpoint
    DEFAULT_URL  = 'http://api.11870.com'
    DEFAULT_BASE = '/api/v2/'

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.logger        = DEFAULT_LOGGER
      self.app_key       = DEFAULT_APP_KEY
      self.secret_key    = DEFAULT_SECRET_KEY
      self.session_token = DEFAULT_SESSION_TOKEN
      self.url           = DEFAULT_URL
      self.base          = DEFAULT_BASE
    end
  end
end
