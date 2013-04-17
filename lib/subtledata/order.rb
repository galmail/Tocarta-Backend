# module SubtleData
  class Subtledata::Order
    
    def initialize(ticket)
      @ticket = ticket
    end
    
    def place_order
      # 1. Check that the ticket is still open. (0451)
      return "error: Ticket is closed!" unless @ticket.is_open?
      # 2. Get the categories for parent category 0. Continue to iterate using the category as the parent category. (0210)
      categories = @ticket.get_categories
      # 3. Get the items for the category. (0211)
      items = @ticket.get_items_of_category(categories.first[:category_id])
      # 4. Get the item modifiers for the item. (0220)
      item_modifiers = @ticket.get_item_modifiers(items.first[:item_id])
      # 5. Add the items to the ticket along with the modifier(s). (0520)
      @ticket.add_items(item,cover_number)
      # 6. Update the quantity for the items that were ordered (if they need to change them). (0530)
      @ticket.update_item_quantity(item_quantity_collection)
      # 7. Delete any items that they don’t want to order. (0531)
      @ticket.delete_items(items_collection)
      # 8. Get the current order (unless you store this locally as well). (0510)
      @ticket.get_items_to_order
      # 9. Place the current order. (0511)
      order_result = @ticket.place_current_order
      if order_result[:ok]
        # wait order_result[:secs_to_wait]
        # 10. Show the current ticket items. (0500)
        @ticket.get_all_items
      end
      
      
      
      return "order placed!"
    end
    
    
    

    def create(order)
      response = @client.get "0480", order_to_subtledata(order)

      if response.status == 200
        result = response.body.split("|")
        if result[1].to_i > 0 # success
          return {order_id: result[1]}
        else
          raise response.inspect
          return {
            error: (errors[result[1]].present? ? errors[result[1]] : result[1])
          }
        end
      end
      return {error: "General Failure"}
    end

    def errors
      {
        "0" => "General Failure",
        "-1" => "Wrong Location ID",
        "-2" => "Wrong Revenue Center ID",
        "-3" => "Wrong User ID",
        "-4" => "Wrong Device ID",
        "-5" => "Wrong Table ID",
        "-6" => "User ID Error",
        "-9" => "Does not meet geo-fencing limitations",
        "-100" => "Not using HTTPS",
        "-111" => "MICROS Transaction Services License error",
        "-131" => "MICROS employee not set properly",
        "-151" => "MICROS table not setup properly",
        "-200" => "MICROS 9700 API Workstation Not Configured",
        "-201" => "POS System Type Not Supported"
      }
    end

    protected

      def payment(payment)
        "#{tender(payment[:type])}^^^^^^^^^#{payment[:amount]}^0^0"
      end

      #SDItemID^Qty^ModifierCollection\x0B766^~
      def items(items)
        items.collect{|i| "#{i[:subtle_data_id]}^#{i.count}^^"}.join("~")
      end

      def modifiers
        #ModiferID\x0BModiferID etc
      end

      def tender(type)
        tenders = {
          "Visa" => 1,
          "MasterCard" => 2,
          "Discover" => 3,
          "American Express" => 4,
          "Cash" => 5,
          "Check" => 6
        }

        return tenders[type] || 7
      end

      # params is an ordered array
      def payload(method, params)
        {"Q" => "#{method}#{method == '0000' ? '' : @session_token}|#{params.join("|")}"}
      end

      #|LocationID|0|0|RevenueCenterID|TerminalId|UserID|DeviceID|1|0|notes|ITEMS|PAYMENT|0|0|
      def order_to_subtledata(order)
        [ @client.location_id, 0, 0, 0, 0, @client.user_id, @client.device_id, 1, 0, "", "#{items(order[:line_items])}", payment(order[:payment]), 0, 0]
      end
  end
# end