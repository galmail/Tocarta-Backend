module Subtledata
  class Client
    # Defines methods related to Menu
    module Menu
      # Get categories
      # @param args [Array] location,parent cat,in store?, delivery?, rake out?
      # @return [Array] with separated fields (see SD Api docs)
      def get_menu_categories(args)
        basic_check(args)

        r = get(@base, { "0200#{@session_token}" => args }, { format_out: 'parse' } )
      end

      # Get items for a location by category
      # @param args [Array] location_id, category_id, in_store?, delivery?, take_out?
      # @param description [Boolean] if true add description to items
      # @return [Array] with separated fields (see SD Api docs)
      def get_menu_items_for_location_by_category(args, description = false)
        basic_check(args)
        meth = description ? '0205' : '0201'
        r = get(@base, { "#{meth}#{@session_token}" => args }, { format_out: 'parse' } )
      end

      # Get all items for a location by category
      # @note main difference with no-all method seems to be then language arg
      # @param args [Array] location_id, language_id, category_id, in_store?, delivery?, take_out?
      # @param description [Boolean] if true add description to items
      # @return [Array] with separated fields (see SD Api docs)
      def get_all_menu_items_for_location_by_category(args, description = false)
        basic_check(args)
        meth = description ? '0206' : '0202'
        r = get(@base, { "0202#{@session_token}" => args }, { format_out: 'parse' } )
      end
    end
  end
end

