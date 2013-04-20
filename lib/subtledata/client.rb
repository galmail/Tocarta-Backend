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
# module SubtleData
#  class Subtledata::Client
#    
#    attr_accessor :user_id, :device_id, :user_guid, :latitude, :longitude
#
#    def initialize(sd_settings = self.sd_settings)
#      @url = sd_settings[:url]
#      @base          = sd_settings[:base]
#      @secret        = sd_settings[:secret]
#      # @user_id     = sd_settings[:user][:user_id]
#      # @device_id   = sd_settings[:user][:device_id]
#      # @location_id = sd_settings[:location_id]
#      ## @session_token = startup
#    end
#
#    def sd_settings
#      {
#        :url => "https://www.subtledata.com",
#        :base => "/API/M/1/",
#        :secret => "RzArM1VQ",
#        :location_id => 611,
#        :user => {
#          :username => "aaaaaaaa",
#          :password => "bbbbbbbb",
#          :email => "aaabbb@company.com",
#          # if user exists, you must indicate the following settings
#          :user_id => "1644",
#          :device_id => "1275",
#          :user_guid => "ed83a73e-578c-4263-9ef2-f76c7bc60d1e",
#          # setting user's gps location (Austing Texas Subtledata Default Location)
#          :latitude => "30.36269",
#          :longitude => "-97.980011"
#        },
#        :secret_keys => {
#          :android_phone => "RzArM1VP",
#          :android_tablet => "RzArM1VQ",
#          :app_mobi => "RzArM1VR",
#          :blackberry_phone => "RzArM1VS",
#          :blackberry_tablet => "RzArM1VT",
#          :desktop_app => "RzArM1VU",
#          :ipad => "RzArM1VV",
#          :iphone => "RzArM1VW",
#          :ipod_touch => "RzArM1VX",
#          :website => "RzArM1VY",
#          :windows_phone => "RzArM1VZ"
#        },
#        :employees => [
#          {:username => "test", :password => "1234"}
#        ]
#      }
#    end
#
#    def set_gps_location(latitude,longitude)
#      response = get("0105",[@user_id,latitude,longitude])
#      results = response.body.split("|")
#      if results[1].to_i <= 0
#        return {error: "Failed"}
#      else
#        @latitude = latitude
#        @longitude = longitude
#        return {user_id: @user_id, latitude: @latitude, longitude: @longitude}
#      end
#    end
#
#    def get_walked_tickets
#      response = get("0150",[@user_id])
#      results = response.body.split("|")
#      return results[1]
#    end
#
#    def get_locations
#      distance = "10" # within 10 miles
#      name_of_location = ""
#      response = get("0310",[distance,@latitude,@longitude,0,name_of_location])
#      results = response.body.split("|")
#      position = results[1].split("^")
#      i = 0
#      final_res = []
#      while i < position.length
#        final_res.push({location_id: position[i], name: position[i+1], address: position[i+2],lat: position[i+7], long: position[i+8]})
#        i+=28
#      end
#      return final_res
#    end
#
#    def get_revenue_centers(location_id)
#      response = get("0330",[location_id])
#      results = response.body.split("|")
#      position = results[1].split("^")
#      i = 0
#      final_res = []
#      while i < position.length
#        final_res.push({center_id: position[i], name: position[i+1], default: position[i+2]})
#        i+=3
#      end
#      return final_res
#    end
#
#    def get_tables(location_id)
#      response = get("0331",[location_id,0])
#      results = response.body.split("|")
#      position = results[1].split("^")
#      i = 0
#      final_res = []
#      while i < position.length
#        final_res.push({table_id: position[i], identifier: position[i+1], name: position[i+2]})
#        i+=3
#      end
#      return final_res
#    end
#
#    def open_new_ticket(location_id,center_id,table_id,num_people,bizexp,ticket_desc,ticket_name)
#      response = get("0410",[location_id,center_id,@user_id,@device_id,table_id,num_people,bizexp,ticket_desc,@latitude,@longitude,ticket_name])
#      results = response.body.split("|")
#      if results[1].to_i <= 0
#        return {ok: false, error: new_ticket_errors[results[1]]}
#      else
#        return {ok: true, ticket_id: results[1]}
#      end
#    end
#
#    def user
#      Subtledata::User.new(self)
#    end
#
#    def order
#      Subtledata::Order.new(self)
#    end
#
#    def get(method, params)
#      connection.get @base, payload(method, params)
#    end
#
#    def connection
#      return @conn if @conn
#      @conn = Faraday.new(url: @url) do |faraday|
#        faraday.request :url_encoded
#        faraday.adapter Faraday.default_adapter
#      end
#
#      startup if @session_token.nil?
#      @conn
#    end
#
#    protected
#      # takes the method number and an array to create Subtle Data Format
#      def payload(method, params)
#        {"Q" => "#{method}#{method == '0000' ? '' : @session_token}|#{params.join("|")}"}
#      end
#
#      def startup
#        response = @conn.get @base, payload("0000", [@secret])
#        @session_token = response.body.split('|')[1]
#      end
#      
#      def new_ticket_errors
#        {
#          "0" => "General failure.",
#          "-1" => "Wrong Location ID",
#          "-2" => "Wrong Revenue Center ID",
#          "-3" => "Wrong User ID",
#          "-4" => "Wrong Device ID",
#          "-5" => "Wrong Table ID",
#          "-9" => "Does not meet geo-fencing limitations",
#          "-111" => "MICROS Transaction Services License error (TSL not configured properly)",
#          "-131" => "MICROS employee not setup properly (Employee class not be found in the status table)",
#          "-151" => "MICROS table not setup properly (Table was not found in revenue center)",
#        }
#      end
#      
#      
#  end
# end
