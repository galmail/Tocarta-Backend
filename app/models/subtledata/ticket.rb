# module SubtleData
  class Subtledata::Ticket

    def initialize(client)
      @client = client
    end

    def dine_in()
      # 1. Authenticate User
      @client.user.authenticate(@client.sd_settings[:user])
      # 2. Set GPS location
      @client.set_gps_location(@client.sd_settings[:user][:latitude],@client.sd_settings[:user][:longitude])
      # 3. Check to make sure that they do not have any walked tickets.
      @client.get_walked_tickets
      # 4. Get the locations near the user and select the first one
      location_id = @client.get_locations.first[:location_id]
      # 5. Get the revenue centers for that location. Find the one that is for dine in. (the first one)
      center_id = @client.get_revenue_centers(location_id).first[:center_id]
      # 6. List tables
      table_id = @client.get_tables(location_id).first[:table_id]
      # 7. Create a new ticket for dine-in
      num_people = 4
      bizexp = 0
      ticket_desc = "Smith Family Dinner"
      ticket_name = "Smith Family"
      @ticket_id = @client.open_new_ticket(location_id,center_id,table_id,num_people,bizexp,ticket_desc,ticket_name)
    end
    
  end
# end