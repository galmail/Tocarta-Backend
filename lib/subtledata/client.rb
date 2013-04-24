module Subtledata
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    # include Subtledata::Client::Utils
    include Subtledata::Client::User
    include Subtledata::Client::Menu

    private
    def basic_check(*args)
      raise ArgumentError, "need @session_token" if     @session_token.nil?
      raise ArgumentError, "args must be array"  unless args.is_a?(Array)
      rescue ArgumentError => e
        puts e.message
        puts e.backtrace.inspect
    end
  end
end
