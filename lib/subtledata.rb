# TODO: add errors file
require 'subtledata/configuration'
require 'subtledata/api'
require 'subtledata/client'
require 'subtledata/response'

module Subtledata
  extend Configuration

  # Alias for Subtledata::Client.new
  #
  # @return [Subtledata::Client]
  def self.client(options={})
    Subtledata::Client.new(options)
  end

  # Delegate to Subtledata::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Subtledata::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end
