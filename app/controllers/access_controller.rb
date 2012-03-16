class AccessController < ApplicationController

  private
  
  def identify_tablet
    @tablet = Tablet.find(:first, :conditions => { :access_key => params[:key] , :active => true })
    if @tablet.nil?
      render :text => "You dont have access with this license.", :status => :forbidden
    else
      @table = @tablet.table
      @restaurant = @table.restaurant
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
      activity[:table_number] = activity.table.number
      activity[:date] = activity.created_at.to_s
      activity[:checked] = (!activity.ack.nil?)
      #duration = Time.now - activity.created_at.time
      #activity[:date] = ChronicDuration.output(duration.to_i, :format => :long)
      #spanish_time = Chronic18n.parse(activity[:date], :es)
      #activity[:date] = spanish_time if !spanish_time.nil?
  end
  
end
