class Api::AnalyticsController < AccessController
  
  # TODO Not implemented yet
  # This method should return the rating for each comment_type in the specified dates
  # It should then be display as a bar chart: x=rating, y=# of comments
  def comments_rating(comment_type,from_date,to_date)
    result = [
      {:rating=>1,:comments=>1},
      {:rating=>2,:comments=>0},
      {:rating=>3,:comments=>0},
      {:rating=>4,:comments=>0},
      {:rating=>5,:comments=>2},
      {:rating=>6,:comments=>0},
      {:rating=>7,:comments=>5},
      {:rating=>8,:comments=>8},
      {:rating=>9,:comments=>6},
      {:rating=>10,:comments=>2}
    ]
    respond_to do |format|
      format.xml  { render :xml => result.to_xml }
      format.json  { render :json => result.to_json }
    end
  end
  
  # TODO Not implemented yet
  # This method should return the average time to ack an activity in the specified dates
  # It should then be display as a line chart: x=days, y=ack_average_time
  def waiters_ack_timing(activity,from_date,to_date)
    result = [
      {:date=>'05/04/2011',:ack_average_time_in_seconds=>12.5},
      {:date=>'06/04/2011',:ack_average_time_in_seconds=>11},
      {:date=>'07/04/2011',:ack_average_time_in_seconds=>13},
      {:date=>'08/04/2011',:ack_average_time_in_seconds=>10},
      {:date=>'09/04/2011',:ack_average_time_in_seconds=>10.5},
      {:date=>'10/04/2011',:ack_average_time_in_seconds=>9}
    ]
    respond_to do |format|
      format.xml  { render :xml => result.to_xml }
      format.json  { render :json => result.to_json }
    end
  end
  
  # TODO Not implemented yet
  # This method should return the list of dishes and the number of time these were ordered in the specified dates and category
  # It should then be display as a pie chart: x=dishes, y=orders
  def most_order_dishes(category,from_date,to_date)
    result = [
      {:dish=>'Pasta con tomate',:orders=>210},
      {:dish=>'Hamburguesa',:orders=>178},
      {:dish=>'Pizza Vegetariana',:orders=>168},
      {:dish=>'Helado de Chocolate',:orders=>142},
      {:dish=>'Cafe o Te',:orders=>192}
    ]
    respond_to do |format|
      format.xml  { render :xml => result.to_xml }
      format.json  { render :json => result.to_json }
    end
  end
  
  
  
end
