class Api::MeWaiterController < AccessController
  
  before_filter :identify_device, :setup_language, :except => [:hello]
  
  def hello
    @result = true
  end
  
  def login
    ok = false
    validate_params(['device_id'])
    if @waiter.device_id.nil? or @waiter.device_id=="" 
      @waiter.device_id = params[:device_id]
      @waiter.save
      ok = true
    else
      ok = (@waiter.device_id == params[:device_id])
    end
    
    if ok
      @result = {
        :api_key => 'RzArM1VY',
        :location_id => @restaurant.sd_location_id,
        :device_id => @waiter.device_id,
        :user_id => @waiter.sd_userid,
        :employee_id => @waiter.sd_employeeid
      }
    else
      @result = {
        :error => 'Login Failed!'
      }
    end
  end
  
  
  def modifiers
    @modifier_list_sets = @restaurant.modifier_list_sets
  end
  
  def suggestions
    @suggestions = @restaurant.suggestions
  end
  
end
