class Api::CommandCenterController < AccessController
  before_filter :identify_tablet, :setup_language, :setup_sencha_friendly_json
  
  def get_last_activities
    num_activities = params[:num_activities]
    num_activities = 50 if num_activities.nil?
    activities = RestaurantActivity.where(:restaurant_id => @restaurant.id).order('created_at DESC').limit(num_activities)
    activities.each {|activity| setup_activity(activity)}
    respond_to do |format|
      format.xml  { render :xml => activities.to_xml }
      format.json  { render :json => activities.to_json }
    end
  end
  
  def ack_activity
    resp = {:result => false}
    activity = RestaurantActivity.find(:first,:conditions => {:restaurant_id => @restaurant.id, :id => params[:activity_id]})
    if activity != nil
      activity.ack = DateTime.now
      resp[:result] = activity.save
    end
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def load_settings
    settings = [ @restaurant.restaurant_setting ]
    respond_to do |format|
      format.xml  { render :xml => settings.to_xml }
      format.json  { render :json => settings.to_json }
    end
  end
  
  def load_tables
    tables = Table.where(:restaurant_id => @restaurant.id).order('number ASC')
    respond_to do |format|
      format.xml  { render :xml => tables.to_xml }
      format.json  { render :json => tables.to_json }
    end
  end
  
  def get_order
    #validate_params(['order_id'])
    order_items = []
    if params[:order_id]
      order = Order.find_by_id(params[:order_id])
      order_items = order.order_items
      # lets get dish name for each order_item
      order_items.each{|order_item|
        if !order_item.dish.nil?
          order_item[:item_name] = order_item.dish.name
          order_item[:item_price] = order_item.dish.price
          order_item[:total] = order_item.dish.price * order_item.quantity
        end
      }
    end
    respond_to do |format|
      format.xml  { render :xml => order_items.to_xml }
      format.json  { render :json => order_items.to_json }
    end
  end
  
  def get_new_notifications
    resp = {:msg => "Not Implemented Yet"}
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
end

