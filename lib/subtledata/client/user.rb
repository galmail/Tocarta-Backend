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
        r = get(@base, { "0105#{@session_token}" => args }, {format_out: 'boolean'})
      end

    end
  end
end
