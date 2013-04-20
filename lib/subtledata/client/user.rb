module Subtledata
  class Client
    # Defines methods related to users
    module User
      # Create a user
      # @param args [Array] See subtledata api for arguments
      # @return [Array] See Subtledata api
      def create_user(*args)
        basic_check(args)
        r = get(@base, { "0110#{@session_token}" => args } )
      end

      # Authenticate user
      def auth_user(*args)
        basic_check(args)
        r = get(@base, { "0111#{@session_token}" => args } )
      end

      # Set user GPS location
      def set_gps_location(*args)
        basic_check(args)
        r = get(@base, { "0105#{@session_token}" => args }, {boolean: true})
      end

      private

      def basic_return(output)
        return true  if output == '1'
        return false if output == '0'
      end

      def basic_check(*args)
        raise ArgumentError, "need @session_token" if     @session_token.nil?
        raise ArgumentError, "args must be array"  unless args.is_a?(Array)
        rescue ArgumentError => e
          puts e.message
          puts e.backtrace.inspect
      end
    end
  end
end
#  class Subtledata::User
#
#    def initialize(client)
#      @client = client
#    end
#    
#    def create(sd_user_settings)
#      response = @client.get "0110", [
#        sd_user_settings[:username],
#        sd_user_settings[:password],
#        sd_user_settings[:first_name] || sd_user_settings[:username],
#        sd_user_settings[:middle_name],
#        sd_user_settings[:last_name] || "Last Name",
#        sd_user_settings[:dob],
#        sd_user_settings[:cell_phone],
#        sd_user_settings[:email],
#        sd_user_settings[:latitude],
#        sd_user_settings[:longitude],
#        sd_user_settings[:guid] || "123456"
#      ]
#      results = response.body.split("|")
#      if results[1].to_i <= 0
#        return {error: create_user_errors[results[1]]}
#      else
#        @client.user_id = results[1]
#        @client.device_id = results[2]
#        @client.user_guid = results[3]
#        return {user_id: results[1], device_id: results[2], user_guid: results[3]}
#      end
#    end
#    
#    def authenticate(sd_user_settings)
#      response = @client.get "0111", [
#        sd_user_settings[:username],
#        sd_user_settings[:password],
#        sd_user_settings[:latitude] || "0",
#        sd_user_settings[:longitude] || "0",
#        @client.device_id
#      ]
#      results = response.body.split("|")
#      if results[1].to_i <= 0
#        return {error: authenticate_user_errors[results[1]]}
#      else
#        @client.user_id = results[1]
#        @client.device_id = results[2]
#        @client.user_guid = results[3]
#        return {user_id: results[1], device_id: results[2], user_guid: results[3]}
#      end
#    end
#    
#    #### list of error codes ####
#    
#    def create_user_errors
#      {
#        "0" => "General failure. Try again.",
#        "-1" => "Username not long enough",
#        "-2" => "Password not long enough",
#        "-3" => "First name not passed",
#        "-5" => "Last name not passed",
#        "-6" => "Date of birth not passed",
#        "-8" => "Bad email address",
#        "-11" => "Unique identifier not passed",
#        "-100" => "Not using HTTPS",
#        "-101" => "Username already exists"
#      }
#    end
#    
#    def authenticate_user_errors
#      {
#        "0" => "General failure. Try again.",
#        "-1" => "Username missing",
#        "-2" => "Password not long enough",
#        "-5" => "Unique Identifier not passed",
#        "-100" => "Not using HTTPS"
#      }
#    end
#  end
# end
