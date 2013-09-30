class Api::TocartasController < AccessController
  #skip_before_filter  :verify_authenticity_token
  before_filter :identify_device, :setup_language, :except => [:hello]
  
  def hello
    @result = true
  end
  
  def im_alive
    @result = false
    @tablet.alive = Time.now
    @result = @tablet.save
  end

  def reset_license
    @tablet.activated = false
    @tablet.last_menu_sync = nil
    @result = @tablet.save
  end

  def get_supported_langs
    @langs = @restaurant.restaurant_setting.supported_lang
  end

  def get_restaurant_info
    if @restaurant.name == 'Sushibar Restaurant'
      @cachetime = 12.weeks
    else
      @cachetime = 2.minutes
    end
    @cachekey = "rest#{@restaurant.id}/locale#{I18n.locale}"

    # show banners
    sort_and_filter(@restaurant.restaurant_banners,nil,nil,nil,nil)
    # show survey questions
    sort_and_filter(@restaurant.chain.survey_questions,nil,nil,nil,nil)
    @menus = @restaurant.active_menus
    # show only active elements
    @menus.each { |menu|
      ##### sorting and filtering sections #####
      sort_and_filter(menu.sections,nil,nil,nil,nil)
      menu.sections.each { |section|
        ##### sorting and filtering dishes of the sections #####
        sort_and_filter(section.dishes,nil,nil,nil,nil)
        section.dishes.each { |dish|
          ##### sorting and filtering comments #####
          sort_and_filter(dish.comments,:created_at,:approved,true,MAX_COMMENTS_PER_DISH)
        }
        ##### sorting and filtering subsections #####
        sort_and_filter(section.subsections,nil,nil,nil,nil)
        section.subsections.each { |subsection|
          ##### sorting and filtering dishes of the subsections #####
          sort_and_filter(subsection.dishes,nil,nil,nil,nil)
          subsection.dishes.each { |dish|
            ##### sorting and filtering comments #####
            sort_and_filter(dish.comments,:created_at,:approved,true,MAX_COMMENTS_PER_DISH)
          }
        }
      }
    }
  end

  def get_images_to_download
    @images = []
    last_update = 10.years.ago
    if @tablet.last_menu_sync!=nil and params[:all]!="yes"
      last_update = @tablet.last_menu_sync
    end

    # get all common icons
    DishType.all.each { |dish_type|
      if !dish_type.icon_file_name.nil? and dish_type.icon_updated_at > last_update
        @images << dish_type.icon.url(:small_icon)
        @images << dish_type.icon.url(:big_icon)
      end
    }

    # get the chain logo and backgrounds
    if !@restaurant.chain.logo_file_name.nil? and @restaurant.chain.logo_updated_at > last_update
      @images << @restaurant.chain.logo.url(:medium)
    end
    if !@restaurant.chain.i18nbg_file_name.nil? and @restaurant.chain.i18nbg_updated_at > last_update
      @images << @restaurant.chain.i18nbg.url
    end
    if !@restaurant.chain.bg_file_name.nil? and @restaurant.chain.bg_updated_at > last_update
      @images << @restaurant.chain.bg.url
    end

    # get the restaurant banners in multiple languages
    default_locale = I18n.locale
    begin
      langs = @restaurant.restaurant_setting.supported_lang
      langs.shift
      langs.each { |lang|
        # setup locale now
        I18n.locale,params[:locale] = lang,lang
        @restaurant.restaurant_banners.each { |banner|
          if !banner.photo_file_name.nil? and banner.photo_updated_at > last_update
            @images << banner.photo.url(:banner)
          end
        }
      }
    rescue Exception=>e
      # handle e
      puts "An error ocurred line 92 of tocartas_controller"
    end
    I18n.locale,params[:locale] =  default_locale,default_locale 

    # get all the photos of the menus, sections, subsections and dishes
    @restaurant.menus.each { |menu|

      if !menu.skin.nil? and menu.skin.stylesheet_updated_at > last_update
        @images << menu.skin.stylesheet.url
      end

      menu.sections.each { |section|
        if !section.photo_file_name.nil? and section.photo_updated_at > last_update
          @images << section.photo.url(:mini)
          @images << section.photo.url(:thumb)
        end
        section.dishes.each { |dish|
          if !dish.photo_file_name.nil? and dish.photo_updated_at > last_update
            @images << dish.photo.url(:mini)
            @images << dish.photo.url(:thumb)
            @images << dish.photo.url(:large)
          end
        }
        section.subsections.each { |subsection|
          if !subsection.photo_file_name.nil? and subsection.photo_updated_at > last_update
            @images << subsection.photo.url(:mini)
            @images << subsection.photo.url(:thumb)
          end
        }
      }
    }
  end

  def confirm_downloaded_images
    @tablet.last_menu_sync = Time.now
    if @tablet.save
      @result = true
    else
      @result = false
    end
  end

  def call_waiter
    @result = false
    # insert new activity
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.restaurant = @restaurant
    restaurant_activity.name = "call_waiter"
    restaurant_activity.table = @table
    @result = restaurant_activity.save
    # push activity to server
    trigger_activity(restaurant_activity)
    # update table status
    @table.status = restaurant_activity.name
    @table.save
  end

  def request_bill
    @result = false
    # insert new activity
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.restaurant = @restaurant
    restaurant_activity.name = "request_bill"
    restaurant_activity.table = @table
    @result = restaurant_activity.save
    # push activity to server
    trigger_activity(restaurant_activity)
    # update table status
    @table.status = restaurant_activity.name
    @table.save
  end

  def checkin_table
    @result = false
    validate_params(['table','dinners','language','new_table'])
    # this tablet now belongs to the new table
    table = @restaurant.tables.select { |tb| tb.number==params[:table].to_i }.first
    return false if table.nil?

    @tablet.table = table
    @tablet.save

    if params[:new_table]!="true"
      @result = true
      return true
    end

    @table = @tablet.table
    @table.dinners = params[:dinners]
    @table.language = params[:language]
    @table.save

    # insert new activity
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.restaurant = @restaurant
    restaurant_activity.name = "checked" # as a check in
    restaurant_activity.table = @table
    @result = restaurant_activity.save
    @table.status = restaurant_activity.name
    @table.save
  end

  def checkout_table
    @result = false
    # get last checkedin activity of this table
    restaurant_activity = RestaurantActivity.find(:first,:conditions => {:table_id => @table.id, :name => "checked"}, :order => "created_at DESC")
    if restaurant_activity != nil
      restaurant_activity.ack = DateTime.now
      @result = restaurant_activity.save
    end
    @table.status = restaurant_activity.name
    @table.save
  end

  def get_sent_order_items
    # get all orders since last checked in
    activity = RestaurantActivity.find(:first,:conditions => {:table_id => @table.id, :name => "checked"}, :order => "updated_at DESC")
    if activity != nil
      orders = Order.where('table_id = ? AND created_at > ?',@table.id,activity.updated_at)
      @order_items = orders.collect { |order|
        order.order_items.select { |order_item| (!order_item.dish.nil?) ? order_item.dish.rate_me : nil }
      }.flatten.uniq { |order_item| order_item.dish.id  }
    end
  end

  def make_order
    @result = false
    validate_params(['order'])
    order_obj = params[:order]
    # create and save order
    order = Order.new
    order.tablet = @tablet
    order.table = @table
    order.total = order_obj["total"]
    order.save

    if order_obj["order_items"].class.to_s.downcase != "array"
      order_obj["order_items"] = [ order_obj["order_items"] ]
    end

    order_obj["order_items"].each { |order_item_obj|
      order_item = OrderItem.new
      order_item.order = order
      if order_item_obj["combo_id"]
        # create combo
        combo = Combo.new
        combo.restaurant = @restaurant
        combo.dishes = []
        order_item_obj["combo_dishes"].each { |combo_dish_obj|
          puts "Processing combo dish id = " << combo_dish_obj["id"]
          dish = Dish.find(:first,:conditions => {:id => combo_dish_obj["id"]})
          combo.dishes.push(dish) unless dish.nil?
        }
        # combo.combo_type = ComboType.find(:first,:conditions => {:name => combo_dish_obj["item_name"]})
        combo.name = order_item_obj["item_name"]
        order_item.combo = combo
      else
        dish = Dish.find(:first,:conditions => {:id => order_item_obj["dish_id"]})
        order_item.dish = dish
      end
      order_item.name = order_item_obj["item_name"]
      order_item.quantity = order_item_obj["quantity"]
      order_item.save
    }

    # send it to the waiter
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.restaurant = @restaurant
    restaurant_activity.name = "submit_order"
    restaurant_activity.table = @table
    restaurant_activity.order = order
    @result = restaurant_activity.save
    # push activity to server
    trigger_activity(restaurant_activity)
    # update table status
    @table.status = restaurant_activity.name
    @table.save
  end
  
  def submit_survey
    @result = false
    validate_params(['survey'])
    survey_obj = params[:survey]
    if survey_obj.class.to_s.downcase != "array"
      survey_obj = [ survey_obj ]
    end
    survey_obj.each { |comment_obj|
      comment = Comment.new
      comment.restaurant = @restaurant
      comment.dish = Dish.find(:first,:conditions => {:id => comment_obj["dish_id"].to_i})
      comment.survey_question = SurveyQuestion.find(:first,:conditions => {:id => comment_obj["survey_question_id"].to_i})
      comment.tablet = @tablet
      comment.name = comment_obj["name"]
      comment.email = comment_obj["email"]
      comment.description = comment_obj["description"]
      comment.rating = comment_obj["rating"].to_i if comment_obj["rating"].to_i>0
      comment.save
      # update dish rating
      if !comment.dish.nil? and !comment.rating.nil?
        comment.dish.update_rating(comment.rating)
      end
    }
    @result = true
  end
  
end

