require 'faraday'

module Subtledata
  # Defines constants and methods related to configuration
  module  Configuration
    # An array of valid keys in the options hash
    VALID_OPTIONS_KEYS = [
      :user_id,
      :device_id,
      :user_guid,
      :latitude,
      :longitude,
      :adapter,
      :base,
      :url
    ].freeze

    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default everithing is nil
    DEFAULT_USER_ID   = nil
    DEFAULT_DEVICE_ID = nil
    DEFAULT_USER_GUID = nil
    DEFAULT_LATITUDE  = nil
    DEFAULT_LONGITUDE = nil

    # Default endpoint
    DEFAULT_URL  = 'https://www.subtledata.com'
    DEFAULT_BASE = '/API/M/1'

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
      self.adapter    = DEFAULT_ADAPTER
      self.user_id    = DEFAULT_USER_ID
      self.device_id  = DEFAULT_DEVICE_ID
      self.user_guid  = DEFAULT_USER_GUID
      self.latitude   = DEFAULT_LATITUDE
      self.longitude  = DEFAULT_LONGITUDE
      self.url        = DEFAULT_URL
      self.base       = DEFAULT_BASE
    end
  end
end
