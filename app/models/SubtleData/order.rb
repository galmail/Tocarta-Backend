module SubtleData
  class Order
    def initialize(client)
      @client = client
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
end