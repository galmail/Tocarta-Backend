class Api::MeWaiterController < AccessController
  
  before_filter :identify_device, :setup_language, :except => [:hello]
  
  def hello
    @result = true
  end
  
  def load_pos_ip_address
    @result = false
    if !params[:ip].nil? and params[:ip].length>0
      @restaurant.pos_ip_address = params[:ip]
      @restaurant.save
      @result = true
    end
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
        :employee_id => @waiter.sd_employeeid,
        :role => @waiter.role
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
  
  def tables
    @floors = @restaurant.floors
  end
  
  def payments
    @payments = @restaurant.payments
  end
  
  def user_info
    @waiter
  end
  
  def app_info
    @waiter_app = @waiter.waiter_app
  end
  
  def pos_resources
    @resources = @restaurant.resources
  end
  
  def discounts
    @discounts = @restaurant.active_discounts
  end
  
  
end
