# require File.expand_path('../instagram/error', __FILE__)
require 'onceocho/configuration'
# require 'onceocho/api'
# require 'onceocho/client'
# require 'onceocho/response'

module Onceocho
  extend Configuration

  # Alias for Subtledata::Client.new
  #
  # @return [Subtledata::Client]
  def self.client(options={})
    Onceocho::Client.new(options)
  end

  # Delegate to Onceocho::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Subtledata::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end
