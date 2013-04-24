# module SubtleData
#  class Subtledata::Ticket
#
#    def initialize(client)
#      @client = client
#    end
#
#    def dine_in
#      # 1. Authenticate User
#      @client.user.authenticate(@client.sd_settings[:user])
#      # 2. Set GPS location
#      @client.set_gps_location(@client.sd_settings[:user][:latitude],@client.sd_settings[:user][:longitude])
#      # 3. Check to make sure that they do not have any walked tickets.
#      @client.get_walked_tickets
#      # 4. Get the locations near the user and select the first one
#      location_id = @client.get_locations.first[:location_id]
#      # 5. Get the revenue centers for that location. Find the one that is for dine in. (the first one)
#      center_id = @client.get_revenue_centers(location_id).first[:center_id]
#      # 6. List tables
#      table_id = @client.get_tables(location_id).first[:table_id]
#      # 7. Create a new ticket for dine-in
#      num_people = 4
#      bizexp = 0
#      ticket_desc = "Smith Family Dinner"
#      ticket_name = "Smith Family"
#      result = @client.open_new_ticket(location_id,center_id,table_id,num_people,bizexp,ticket_desc,ticket_name)
#      @ticket_id = result[:ticket_id]
#      return result[:ok]
#    end
#    
#    def is_open?
#      response = @client.get("0451",[@ticket_id])
#      results = response.body.split("|")
#      return results[1].to_i > 0
#    end
#    
#    def get_categories(parent_category = 0)
#      response = @client.get("0210",[@ticket_id,parent_category])
#      results = response.body.split("|")
#      position = results[1].split("^")
#      i = 0
#      final_res = []
#      while i < position.length
#        final_res.push({
#          category_id: position[i],
#          name: position[i+1],
#          instruction_text: position[i+2],
#          has_items: position[i+3],
#          has_subcategories: position[i+4]
#        })
#        i+=5
#      end
#      return final_res
#    end
#    
#    def get_items_of_category(category_id)
#      response = @client.get("0211",[@ticket_id,category_id])
#      results = response.body.split("|")
#      position = results[1].split("^")
#      i = 0
#      final_res = []
#      while i < position.length
#        final_res.push({
#          item_id: position[i],
#          name: position[i+1],
#          price: position[i+2]
#        })
#        i+=3
#      end
#      return final_res
#    end
#    
#    def get_item_modifiers(item_id)
#      response = @client.get("0220",[item_id])
#      results = response.body.split("|")
#      position = results[1].split("^")
#      return {category_id: position[0], name: position[1], description: position[2]}
#    end
#    
#    def add_items(item,cover_number)
#      item_collection = item.join("^")  # ItemId^Quantity^Instructions^OrderModifierCollection
#      response = @client.get("0520",[@ticket_id,@client.user_id,item_collection,cover_number,""])
#      if results[1].to_i <= 0
#        return {error: update_items_errors[results[1]]}
#      else
#        return true
#      end
#    end
#    
#    def update_item_quantity(item_quantity_collection)
#      collection = item_quantity_collection.join("~")  # ItemId^Quantity~ItemId^Quantity~ItemId^Quantity
#      response = @client.get("0530",[@ticket_id,@client.user_id,collection])
#      if results[1].to_i <= 0
#        return {error: update_items_errors[results[1]]}
#      else
#        return true
#      end
#    end
#    
#    def delete_items(items_collection)
#      collection = items_collection.join("~")  # ItemId~ItemId
#      response = @client.get("0530",[@ticket_id,@client.user_id,collection])
#      if results[1].to_i <= 0
#        return {error: update_items_errors[results[1]]}
#      else
#        return true
#      end
#    end
#    
#    def get_items_to_order
#      response = @client.get("0510",[@client.location_id,@ticket_id])
#      results = response.body.split("|")
#      return results[1]
#    end
#    
#    def place_current_order
#      response = @client.get("0511",[@ticket_id,@client.user_id,"",""])
#      results = response.body.split("|")
#      if results[1].to_i <= 0
#        return {ok: false, error: place_order_errors[results[1]]}
#      else
#        return {ok: true, secs_to_wait: results[2]}
#      end
#    end
#    
#    def get_all_items
#      response = @client.get("0500",[@client.location_id,@ticket_id])
#      results = response.body.split("|")
#      return results[1]
#    end
#    
#    def update_items_errors
#      {
#        "0" => "General Failure",
#        "-1" => "Ordering Turned Off",
#        "-2" => "Wrong User ID",
#        "-3" => "Bad Ticket Item ID in collection",
#        "-31" => "Bad Item ID in collection (no items committed)",
#        "-341" => "Bad Modifier ID in collection (no items committed)"
#      }
#    end
#    
#    def place_order_errors
#      {
#        "0" => "General Failure",
#        "-1" => "Bad Ticket ID",
#        "-2" => "Wrong User ID",
#        "-3" => "Too Far Away To Order"
#      }
#    end
#    
#    
#  end
# end
