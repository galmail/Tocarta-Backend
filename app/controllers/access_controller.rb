require 'net/http'

class AccessController < ApplicationController

  def validate_license_key
    @result = false
    if !@tablet.activated
      # @tablet.activated = true unless @tablet.access_key == "demo" or @tablet.access_key == "tocarta"
      # @tablet.save
      @result = true
    end
  end
  
  private
  
  MAX_COMMENTS_PER_DISH = 10
  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  
  def identify_device
    if params[:key]
      @tablet = Tablet.where("access_key = ? AND active = ?", params[:key], true).first
      if @tablet.nil?
        render :text => "You dont have access with this license.", :status => :forbidden
      else
        @table = @tablet.table
        @restaurant = @table.restaurant
      end
    elsif params[:mwkey]
      @waiter = Waiter.where("key = ? AND active = ?", params[:mwkey], true).first
      if @waiter.nil?
        render :text => "You dont have access with this license.", :status => :forbidden
      else
        @restaurant = @waiter.restaurant
      end
    elsif params[:auth_token]
      if current_user.nil?
        render :text => "You dont have access with this license.", :status => :forbidden
      else
        @restaurant = current_user.restaurants.first
      end
    end
  end
  
  def setup_language
    params[:locale] = @restaurant.restaurant_setting.default_language if (params[:locale].nil?)
    I18n.locale = params[:locale]
  end
  
  def setup_sencha_friendly_json
    ActiveRecord::Base.include_root_in_json = false
  end
  
  def validate_params(args_array)
    args_array.each{|arg|
      raise ArgumentError, "Falta pasar el parametro '#{arg}' en la peticion" unless params.keys.include? arg
    }
  end
  
  def setup_activity(activity)
    # convert activity into hash
    activityHash = activity.attributes
    activityHash["table_number"] = activity.table_number
    activityHash["date"] = activity.date
    if !activity.order.nil?
      # setup the order
      activityHash["order"] = activity.order.attributes
      activityHash["order"]["order_items"] = []
      activity.order.order_items.each{ |order_item|
        orderItemHash = order_item.attributes
        if !order_item.dish.nil?
          orderItemHash["item_name"] = order_item.dish.name
        else
          orderItemHash["item_name"] = order_item.combo.name
        end
        activityHash["order"]["order_items"] << orderItemHash
      }
    end
    #spanish_time = Chronic18n.parse(activity[:date], :es)
    #activity[:date] = spanish_time if !spanish_time.nil?
    return activityHash.to_json
  end
  
  def trigger_activity(restaurant_activity)
    # Call HTTP GET proxy with channel and action
    enc_activity = URI.encode(setup_activity(restaurant_activity))
    begin
      Net::HTTP.get(URI.parse("#{ENV['NODE_SERVER']}/proxy?channel=tocarta_restaurant_#{@restaurant.id}_channel&action="+enc_activity))
      # Pusher["tocarta_restaurant_#{@restaurant.id}_channel"].trigger('activity', setup_activity(restaurant_activity))
    rescue
      logger.fatal "Could not trigger_activity to node server!"
    end
  end
  
  def trigger_tablet(key,message)
    # Call HTTP GET proxy with channel and action
    begin
      Net::HTTP.get(URI.parse("#{ENV['NODE_SERVER']}/proxy?channel=tocarta_lk_#{key}_channel&action=#{message}"))
    rescue
      logger.fatal "Could not trigger_tablet to node server!"
    end
    # Pusher["tocarta_lk_#{key}_channel"].trigger(message,{})
  end
  
  def sort_and_filter(items,sort_attr,filter_attr,reverse_sort,limit)
    sort_attr = sort_attr || :position
    filter_attr = filter_attr || :active
    items.sort_by!{|item|
      item_position = 0
      if item[sort_attr].is_a?(Numeric) == false
        item_position = 0
      else
        item_position = item[sort_attr]
      end
    }
    items.reject!{|item| !item[filter_attr]}
    if !reverse_sort.nil? and reverse_sort==true
      items.reverse!
    end
    if !limit.nil?
      items.slice!(limit..-1)
    end
  end
  
end
