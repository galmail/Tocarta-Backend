class Api::TocartasController < AccessController
  before_filter :identify_tablet, :setup_language, :setup_sencha_friendly_json
  
  def validate_license_key
    @result = true
  end
  
  def get_restaurant_info
    # TODO get restaurant menus in all languages
    @menus = @restaurant.menus
    # show only active elements
    @menus.each { |menu|
      ##### sorting and filtering sections #####
      sort_and_filter(menu.sections,nil,nil,nil)
      menu.sections.each { |section|
        ##### sorting and filtering dishes of the sections #####
        sort_and_filter(section.dishes,nil,nil,nil)
        section.dishes.each { |dish|
          ##### sorting and filtering comments #####
          sort_and_filter(dish.comments,:created_at,:approved,true)
        }
        ##### sorting and filtering subsections #####
        sort_and_filter(section.subsections,nil,nil,nil)
        section.subsections.each { |subsection|
          ##### sorting and filtering dishes of the subsections #####
          sort_and_filter(subsection.dishes,nil,nil,nil)
          subsection.dishes.each { |dish|
            ##### sorting and filtering comments #####
            sort_and_filter(dish.comments,:created_at,:approved,true)
          }
        }
      }
    }
  end
  
  
  def get_images_to_download
    @images = []
    last_update = 10.years.ago
    if @tablet.last_menu_sync!=nil and !params[:all]
      last_update = @tablet.last_menu_sync
    end
    # get all the photos of sections, subsections and dishes
    @restaurant.menus.each { |menu|
      menu.sections.each { |section|
        @images << section if !section.photo_file_name.nil? and section.photo_updated_at > last_update
        section.dishes.each { |dish|
          @images << dish if !dish.photo_file_name.nil? and dish.photo_updated_at > last_update
        }
        section.subsections.each { |subsection|
          @images << subsection if !subsection.photo_file_name.nil? and subsection.photo_updated_at > last_update
          subsection.dishes.each { |dish|
            @images << dish if !dish.photo_file_name.nil? and dish.photo_updated_at > last_update
          }
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
    restaurant_activity.name = "Call Waiter"
    restaurant_activity.table = @table
    @result = restaurant_activity.save
    # push activity to server
    #setup_activity(restaurant_activity)
    Pusher["restaurant_#{@restaurant.id}_channel"].trigger('activity', restaurant_activity.to_json)
    # update table status
    @table.status = restaurant_activity.name
    @table.save
  end
  
  def request_bill
    @result = false
    # insert new activity
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.restaurant = @restaurant
    restaurant_activity.name = "Request Bill"
    restaurant_activity.table = @table
    @result = restaurant_activity.save
    # push activity to server
    #setup_activity(restaurant_activity)
    Pusher["restaurant_#{@restaurant.id}_channel"].trigger('activity', restaurant_activity.to_json)
    # update table status
    @table.status = restaurant_activity.name
    @table.save
  end
  
  def checkin_table
    @result = false
    validate_params(['table','dinners','language'])
    # this tablet now belongs to the new table
    tables = @restaurant.tables.select { |table| table.number==params[:table].to_i }
    return false if tables.empty?
    
    @tablet.table = tables.first
    @tablet.save
    
    @table = @tablet.table
    @table.dinners = params[:dinners]
    @table.language = params[:language]
    @table.orders = []
    @table.save
    
    # insert new activity
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.restaurant = @restaurant
    restaurant_activity.name = "Checked In"
    restaurant_activity.table = @table
    @result = restaurant_activity.save
    Pusher["restaurant_#{@restaurant.id}_channel"].trigger('activity', restaurant_activity.to_json)
    @table.status = restaurant_activity.name
    @table.save
  end
  
  def checkout_table
    @result = false
    # insert new activity
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.restaurant = @restaurant
    restaurant_activity.name = "Checked Out"
    restaurant_activity.table = @table
    @result = restaurant_activity.save
    Pusher["restaurant_#{@restaurant.id}_channel"].trigger('activity', restaurant_activity.to_json)
    @table.status = restaurant_activity.name
    @table.save
  end
  
  def get_sent_order_items
    @order_items = @table.orders.collect { |order| order.order_items }.flatten
  end

  # def check_for_updates
    # result = { :new_updates => false }
    # restaurant_setting = @restaurant.restaurant_setting
    # if restaurant_setting != nil
      # if @tablet.last_menu_sync.nil? or (@tablet.last_menu_sync < restaurant_setting.last_menu_sync)
       # result[:new_updates] = true
      # end
    # end
    # respond_to do |format|
      # format.xml  { render :xml => result.to_xml }
      # format.json { render :json => result.to_json }
    # end
  # end
  
  
  

  

  
  
  def make_a_comment
    resp = {:result => false}
    dish = Dish.find(:first, :conditions => { :id => params[:dish_id] })
    comment_name = params[:name]
    comment_description = params[:description]
    comment_rating = params[:rating]
    # insert new comment
    comment = Comment.new
    comment.dish = dish
    comment.name = comment_name
    comment.description = comment_description
    comment.rating = comment_rating
    resp[:result] = comment.save
    # update dish rating
    dish.update_rating(comment_rating) if !dish.nil?
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def change_table_number
    resp = {:validated => false}
    table_number = params[:table_number]
    if !table_number.nil?
      # setup this tablet to that table number
      table = Table.find(:first,:conditions => {:number => table_number, :restaurant_id => @restaurant.id})
      if !table.nil?
        @tablet.table = table
        resp[:validated] = @tablet.save
      end
    end
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def new_client_init
    resp = {:result => false}
    # insert new activity
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.name = "Client Usage"
    restaurant_activity.table = @table
    restaurant_activity.restaurant = @restaurant
    resp[:result] = restaurant_activity.save
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def new_client_end
    resp = {:result => false}
    # update activity
    activity = RestaurantActivity.find(:first,:conditions => {:table_id => @table.id, :name => "Client Usage"}, :order => "created_at DESC")
    if activity != nil
      activity.ack = DateTime.now
      resp[:result] = activity.save
    end
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def make_an_order
    resp = {:result => false}
    validate_params(['order_items'])
    # create and save order
    order = Order.new
    order.tablet = @tablet
    order.save
    params[:order_items].each{|order_item_str|
      order_item_obj = JSON.parse(order_item_str)
      order_item = OrderItem.new
      order_item.order = order
      order_item.dish = Dish.find(:first,:conditions => {:id => order_item_obj['dish_id']})
      order_item.combo_type = ComboType.find(:first,:conditions => {:id => order_item_obj['combo_type_id']})
      order_item.quantity = order_item_obj['quantity']
      order_item.save
    }
    # send it to the waiter
    restaurant_activity = RestaurantActivity.new
    restaurant_activity.restaurant = @restaurant
    restaurant_activity.name = "Submit Order"
    restaurant_activity.table = @table
    restaurant_activity.order = order
    resp[:result] = restaurant_activity.save
    setup_activity(restaurant_activity)
    # push activity to server
    Pusher["restaurant_#{@restaurant.id}_channel"].trigger('activity', restaurant_activity.to_json)
    # update table status
    @table.status = restaurant_activity.name
    @table.save
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def send_comment
    resp = {:result => false}
    # create and save comment
    comment = Comment.new
    comment.restaurant = @restaurant
    comment.dish = Dish.find(:first,:conditions => {:id => params[:dish_id]})
    comment.survey_question = SurveyQuestion.find(:first,:conditions => {:id => params[:survey_question_id]})
    comment.name = params[:name]
    comment.description = params[:description]
    comment.rating = params[:rating]
    resp[:result] = comment.save
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def get_survey_questions
    comment_types = SurveyQuestion.find(:all)
    #resp = {:msg => "Not Implemented Yet"}
    respond_to do |format|
      format.xml  { render :xml => comment_types.to_xml }
      format.json  { render :json => comment_types.to_json }
    end
  end
  
  #####################  CHANGE EVERYTHING BELOW THIS LINE  #####################

  def cache_images
    result = "CACHE MANIFEST\n"
    respond_to do |format|
      format.manifest  { render :text => result }
    end
  end
  
  # TODO TOCARTA need to implement this function
  def supported_languages
    languages = [
      {:name => "english", :code_name => "en"},
      {:name => "spanish", :code_name => "es"}
    ]
    respond_to do |format|
      format.xml  { render :xml => languages.to_xml }
      format.json  { render :json => languages.to_json }
    end
  end
  
  def get_num_sections
    puts "Getting total num of sections"
    resp = {:total_num_sections => 0}
    @restaurant.menus.each{|menu|
      resp[:total_num_sections] += menu.sections.length
    }
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def load_survey_questions
    puts "Loading survey questions"
    survey_questions = []
    if !@restaurant.chain.nil?
      survey_questions = @restaurant.chain.survey_questions
    end
    respond_to do |format|
      format.xml  { render :xml => survey_questions.to_xml }
      format.json  { render :json => survey_questions.to_json }
    end
  end
  
  def load_menus
    puts "Loading the menus"
    menus = @restaurant.menus
    menus.sort_by!{|menu|
      menu_priority = 0
      if !menu.menu_setting.nil? and !menu.menu_setting.priority.nil?
        menu_priority = menu.menu_setting.priority
      end
    }
    respond_to do |format|
      format.xml  { render :xml => menus.to_xml }
      format.json  { render :json => menus.to_json }
    end
  end
  
  def load_sections
    puts "Loading the sections"
    sections = []
    #validate_params(['menu_id'])
    if params[:menu_id].nil? or params[:menu_id].blank?
      @restaurant.menus.each{|menu|
        sections += menu.sections
      }
    else
      menu = Menu.find_by_id(params[:menu_id])
      if !menu.nil? and menu.restaurant === @restaurant
        sections = menu.sections
      end
    end
    sections.sort_by!{|section|
      section[:photo_url] = section.get_photo(params[:offline]) if !section.photo_file_name.nil?
      section_position = 0
      section_position = section.position if section.position.is_a?(Numeric)
    }
    sections = sections.reject{|section| !section.active}
    respond_to do |format|
      format.xml  { render :xml => sections.to_xml }
      format.json  { render :json => sections.to_json }
    end
  end
  
  def load_subsections
    puts "Loading the subsections"
    subsections = []
    #validate_params(['menu_id'])
    if params[:menu_id].nil? or params[:menu_id].blank?
      @restaurant.menus.each{|menu|
        menu.sections.each{|section| subsections += section.subsections }
      }
    else
      menu = Menu.find_by_id(params[:menu_id])
      if !menu.nil? and menu.restaurant === @restaurant
        menu.sections.each{|section| subsections += section.subsections }
      end
    end
    subsections.sort_by!{|subsection|
      subsection[:photo_url] = subsection.get_photo(params[:offline]) if !subsection.photo_file_name.nil?
      subsection_position = 0
      subsection_position = subsection.position if subsection.position.is_a?(Numeric)
    }
    respond_to do |format|
      format.xml  { render :xml => subsections.to_xml }
      format.json  { render :json => subsections.to_json }
    end
  end
  
  
  def load_dishes
    puts "Loading the dishes"
    #validate_params(['section_id'],['subsection_id'])
    dishes = []
    if params[:section_id].nil? or params[:section_id].blank?
      @restaurant.menus.each{|menu|
        menu.sections.each{|section|
          dishes += section.dishes
          section.subsections.each{|subsection|
            dishes += subsection.dishes
          }
        }
      }
    else
      if !params[:subsection_id].nil? and !params[:subsection_id].blank?
        subsection = Subsection.find_by_id(params[:subsection_id])
        if !subsection.nil? and subsection.section.menu.restaurant === @restaurant
          dishes = subsection.dishes
        end
      else
        section = Section.find_by_id(params[:section_id])
        if !section.nil? and section.menu.restaurant === @restaurant
          dishes = section.dishes
        end
      end
    end
    dishes.sort_by!{|dish|
      dish[:photo_url] = dish.get_photo(params[:offline]) if !dish.photo_file_name.nil?
      dish[:thumbnail] = dish.get_thumbnail
      dish[:dish_types] = dish.dish_types.sort_by{|dish_type|
        dish_type_position = 0
        #dish_type_position = dish_type.position if dish_type.position.is_a?(Numeric)
      }
      # meanwhile types as string
      dish[:types] = dish.dish_types.collect{|dish_type| dish_type.dish_class}.join(',')
      dish_position = 0
      #dish_position = dish.position if dish.position.is_a?(Numeric)
    }
    respond_to do |format|
      format.xml  { render :xml => dishes.to_xml }
      format.json  { render :json => dishes.to_json }
    end
  end
  
  def load_comments
    puts "Loading the last 20 comments of each dish ordered by date"
    # get all dishes of the restaurant
    dishes = Dish.joins(:section => {:menu => :restaurant}).where(:restaurants => {:id => @restaurant.id})
    # for each dish, get the top 20 comments order by date
    comments = []
    dishes.each{|dish|
      dish.comments.select!  {|comment| comment.approved }
      dish.comments.sort_by! {|comment| comment.created_at }
      dish.comments.reverse!
      comments = comments.concat(dish.comments.first(20))
    }
    comments.compact!
    respond_to do |format|
      format.xml  { render :xml => comments.to_xml }
      format.json  { render :json => comments.to_json }
    end
  end
  
  def load_dish_types
    puts "Loading the dish types"
    # get all dishes of the restaurant
    dishes = Dish.joins(:section => {:menu => :restaurant}).where(:restaurants => {:id => @restaurant.id})
    # get all dish types of each dish
    dish_types = []
    dishes.each{|dish|
      dish_types = dish_types.concat(dish.dish_types) if !dish.dish_types.empty?
    }
    
    dish_types.uniq!
    dish_types.compact!
    
    respond_to do |format|
      format.xml  { render :xml => dish_types.to_xml }
      format.json  { render :json => dish_types.to_json }
    end
  end
  
  def load_combo_types
    puts "Loading the combo types"
    # get all combo_types of the restaurant
    combo_types = ComboType.find(:all,:conditions => {:restaurant_id => @restaurant.id})
    respond_to do |format|
      format.xml  { render :xml => combo_types.to_xml }
      format.json  { render :json => combo_types.to_json }
    end
  end
  
  def get_pic
    dish = Dish.find(:first)
    render :text => dish.get_photo(true) , :content_type => dish.photo_content_type
  end

  
end

