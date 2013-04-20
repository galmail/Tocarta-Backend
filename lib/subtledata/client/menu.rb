module Subtledata
  class Client
    # Defines methods related to Menu
    module Menu
      # Get categories
      # @param args [Array] location,parent cat,in store?, delivery?, rake out?
      def get_categories(*args)
        basic_check(args)
        r = get(@base, { "0200#{@session_token}" => args }, { format_out: 'parse' } )
      end
    end
  end
end

