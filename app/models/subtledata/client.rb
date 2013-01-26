# module SubtleData
  class Subtledata::Client
    
    attr_accessor :user_id, :device_id, :user_guid

    def initialize(sd_settings = self.sd_settings)
      @location_id = sd_settings[:location_id]
      @secret = sd_settings[:secret]
      # @session_token = startup
      @user_id = sd_settings[:user][:user_id]
      @device_id = sd_settings[:user][:device_id]
      @url = sd_settings[:url]
      @base = sd_settings[:base]
    end
    
    def sd_settings
      {
        :url => "https://www.subtledata.com",
        :base => "/API/M/1/",
        :secret => "RzArM1VQ",
        :location_id => 611,
        :user => {
          :username => "aaaaaaaa",
          :password => "bbbbbbbb",
          :email => "aaabbb@company.com",
          # if user exists, you must indicate the following settings
          :user_id => "1644",
          :device_id => "1275",
          :user_guid => "ed83a73e-578c-4263-9ef2-f76c7bc60d1e"
        }
      }
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