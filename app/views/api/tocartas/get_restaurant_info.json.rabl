### restaurant setting ###

node :name do @restaurant.name end
node :logo do @restaurant.chain.logo.url(:medium).split(ENV['S3_BUCKET']).last end
node :i18nbg do @restaurant.chain.i18nbg.url.split(ENV['S3_BUCKET']).last end
node :bg do @restaurant.chain.bg.url.split(ENV['S3_BUCKET']).last end

child @restaurant.restaurant_setting => :setting do
  attributes :multilang_homepage, :games, :call_waiter_button, :order_button, :request_bill_button, :show_help_button, :show_survey, :show_filters, :access_key, :supported_lang
end

### restaurant banners ###

child @restaurant.restaurant_banners => :banners do
  attributes :id, :name
  node(:large, :unless => lambda {|b| b.photo_file_name.nil? }) do |banner|
    banner.photo.url(:banner).split(ENV['S3_BUCKET']).last
  end
end

### restaurant survey questions ###

child	@restaurant.chain.survey_questions => :survey_questions do
	attributes :id, :name, :description
end

### restaurant menus ###

child @menus do
  attributes :id, :name, :menu_type, :price
  
  node(:stylesheet, :unless => lambda {|m| m.skin.nil? }) do |menu|
    menu.skin.stylesheet.url.split(ENV['S3_BUCKET']).last
  end
  
  child :dishtypes => :dishtypes do
    attributes :id, :name, :description
    node(:small_icon, :unless => lambda {|dt| dt.icon_file_name.nil? }) do |dt|
      dt.icon.url(:small_icon).split(ENV['S3_BUCKET']).last
    end
  end

  child :sections do
    attributes :id, :name, :hasBigSubsections, :dishes_per_page    
    node(:mini, :unless => lambda {|s|
        s.photo_file_name.nil?
      }) do |section|
      section.photo.url(:mini).split(ENV['S3_BUCKET']).last
    end
    node(:thumbnail, :unless => lambda {|s| s.photo_file_name.nil? }) do |section|
      section.photo.url(:thumb).split(ENV['S3_BUCKET']).last
    end
    child(:dishes, :if => lambda { |s| s.subsections.length==0 }) do
      attributes :id, :name, :price, :badge_name
      attributes :video, :unless => lambda { |dish| dish.video.nil? or dish.video=="" }
      
      node :short_title do |dish|
        if dish.short_title.nil? or dish.short_title==""
          dish.name
        else
          dish.short_title
        end
      end
      node :description do |dish|
        if dish.description.nil?
          dish.name
        else
          dish.description
        end
      end
      node(:rating, :unless => lambda {|d| d.rating.nil? }) do |dish| dish.rating.round end
      node(:mini, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
        dish.photo.url(:mini).split(ENV['S3_BUCKET']).last
      end
      node(:thumbnail, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
        dish.photo.url(:thumb).split(ENV['S3_BUCKET']).last
      end
      node(:large, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
        dish.photo.url(:large).split(ENV['S3_BUCKET']).last
      end
      child :comments do
        attributes :id, :name, :description, :rating
      end

      child :dish_types => :dishtypes do
        attributes :name
        node(:small_icon, :unless => lambda {|dt| dt.icon_file_name.nil? }) do |dt|
          dt.icon.url(:small_icon).split(ENV['S3_BUCKET']).last
        end
        node(:big_icon, :unless => lambda {|dt| dt.icon_file_name.nil? }) do |dt|
          dt.icon.url(:big_icon).split(ENV['S3_BUCKET']).last
        end
      end

    end
    
    child :subsections do
      attributes :id, :name
      node :short_title do |subsection|
        subsection.name
      end
      node(:mini, :unless => lambda {|s| s.photo_file_name.nil? }) do |subsection|
        subsection.photo.url(:mini).split(ENV['S3_BUCKET']).last
      end
      node(:thumbnail, :unless => lambda {|s| s.photo_file_name.nil? }) do |subsection|
        subsection.photo.url(:thumb).split(ENV['S3_BUCKET']).last
      end
      child :dishes do
        attributes :id, :name, :price, :badge_name
        attributes :video, :unless => lambda { |dish| dish.video.nil? or dish.video=="" }
        
        node :short_title do |dish|
          if dish.short_title.nil? or dish.short_title==""
            dish.name
          else
            dish.short_title
          end
        end
        node :description do |dish|
          if dish.description.nil?
            dish.name
          else
            dish.description
          end
        end
        node(:rating, :unless => lambda {|d| d.rating.nil? }) do |dish| dish.rating.round end
        node(:mini, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
          dish.photo.url(:mini).split(ENV['S3_BUCKET']).last
        end
        node(:thumbnail, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
          dish.photo.url(:thumb).split(ENV['S3_BUCKET']).last
        end
        node(:large, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
          dish.photo.url(:large).split(ENV['S3_BUCKET']).last
        end
        child :comments do
          attributes :id, :name, :description, :rating
        end
        
        child :dish_types => :dishtypes do
          attributes :name
          node(:small_icon, :unless => lambda {|dt| dt.icon_file_name.nil? }) do |dt|
            dt.icon.url(:small_icon).split(ENV['S3_BUCKET']).last
          end
          node(:big_icon, :unless => lambda {|dt| dt.icon_file_name.nil? }) do |dt|
            dt.icon.url(:big_icon).split(ENV['S3_BUCKET']).last
          end
        end
        
      end
    end
  end
end
