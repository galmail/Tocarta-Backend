class Api::CommandCenterController < AccessController
  before_filter :identify_tablet, :setup_language
  
  MAX_NUM_ACTIVITIES_TO_LOAD = 100
  
  def get_restaurant_situation
    num_activities = params[:num_activities]
    num_activities = MAX_NUM_ACTIVITIES_TO_LOAD if num_activities.nil?
    @activities = RestaurantActivity.where('restaurant_id = ? AND name IS NOT ?',@restaurant.id,'checked').order('created_at DESC').limit(num_activities)
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
  
end

