# require File.expand_path('../instagram/error', __FILE__)
require 'subtledata/configuration'
# require File.expand_path('../instagram/api', __FILE__)
# require File.expand_path('../instagram/client', __FILE__)
# require File.expand_path('../instagram/response', __FILE__)

module Subtledata
  extend Configuration

  # Alias for Subtledata::Client.new
  #
  # @return [Subtledata::Client]
  def self.client(options={})
    puts "hola"
    # Subtledata::Client.new(options)
  end
end
