class Api::CommandCenterController < AccessController
  before_filter :identify_tablet, :setup_language
  
  MAX_NUM_ACTIVITIES_TO_LOAD = 50
  
  def get_restaurant_situation
    num_activities = params[:num_activities]
    num_activities = MAX_NUM_ACTIVITIES_TO_LOAD if num_activities.nil?
    @activities = RestaurantActivity.where('restaurant_id = ? AND name != ?',@restaurant.id,'checked').order('created_at DESC').limit(num_activities)
  end
  
  def ack_activity
    validate_params(['activity_id'])
    @result = false
    activity = RestaurantActivity.find(:first,:conditions => {:restaurant_id => @restaurant.id, :id => params[:activity_id]})
    if activity != nil
      activity.ack = DateTime.now
      @ack = DateTime.now.to_s
      @result = activity.save
    end
  end
  
  def whos_alive
    validate_params(['checked'])
    # rest = Restaurant.find(params[:restaurant_id])
    rest = @restaurant
    # get all tablets of this restaurant and trigger them
    unless rest.nil?
      if params[:checked] == 'yes'
        @now = 20.seconds.ago
      else
        @now = Time.now
        rest.tablets.each { |tablet|
          trigger_tablet(tablet.access_key,'alive')
        }
      end
      @tablets = rest.tablets
    end
  end
  
  def update_tablets
    @result = false
    # validate_params(['restaurant_id'])
    # rest = Restaurant.find(params[:restaurant_id])
    rest = @restaurant
    # get all tablets of this restaurant and trigger them
    unless rest.nil?
      if params[:tablet_id].nil?
        rest.tablets.each { |tablet|
          trigger_tablet(tablet.access_key,'update')
        }
      else
        tablet = Tablet.find_by_id(params[:tablet_id])
        return false if tablet.nil?
        trigger_tablet(tablet.access_key,'update')
      end
      @result = true
    end
  end

end

