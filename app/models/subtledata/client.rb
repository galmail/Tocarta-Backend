# module SubtleData
  class Subtledata::Client
    
    attr_reader :location_id, :user_id, :device_id

    def initialize(secret = 'RzArM1VQ', location_id = 611, options = {})
      @location_id = location_id # Cloud POS for testing called ToCarta Sandwich Shop
      @secret = secret # Tablet android app
      @session_token = options[:session_token]
      @user_id = options[:user_id]
      @device_id = options[:device_id]
      @url = "https://www.subtledata.com"
      @base = "/API/M/1/"
    end

    def user
      Subtledata::User.new(self)
    end

    def order
      Subtledata::Order.new(self)
    end

    def get(method, params)
      connection.get @base, payload(method, params)
    end

    def connection
      return @conn if @conn
      @conn = Faraday.new(url: @url) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end

      startup if @session_token.nil?
      @conn
    end

    protected
      # takes the method number and an array to create Subtle Data Format
      def payload(method, params)
        {"Q" => "#{method}#{method == '0000' ? '' : @session_token}|#{params.join("|")}"}
      end

      def startup
        response = @conn.get @base, payload("0000", [@secret])
        @session_token = response.body.split('|')[1]
      end
  end
# end