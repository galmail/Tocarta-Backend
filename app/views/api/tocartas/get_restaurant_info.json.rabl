object false

### restaurant setting ###

node :name do @restaurant.name end
node :logo do @restaurant.chain.logo.url(:medium).split(ENV['S3_BUCKET']).last end

child @restaurant.restaurant_setting => :setting do
  attributes :multilang_homepage, :games, :call_waiter_button, :order_button, :request_bill_button, :show_help_button, :show_survey
end

### restaurant survey questions ###

child	@restaurant.chain.survey_questions => :survey_questions do
	attributes :id, :name, :description
end

### restaurant menus ###

child @menus do
  object false
  attributes :id, :name, :menu_type
  
  child :sections do
    attributes :id, :name, :hasBigSubsections
    node(:mini, :unless => lambda {|s| s.photo_file_name.nil? }) do |section|
      section.photo.url(:mini).split(ENV['S3_BUCKET']).last
    end
    node(:thumbnail, :unless => lambda {|s| s.photo_file_name.nil? }) do |section|
      section.photo.url(:thumb).split(ENV['S3_BUCKET']).last
    end
    child :dishes do
      attributes :id, :name, :description, :price, :badge_name
      node(:rating, :unless => lambda {|d| d.rating.nil? }) do |dish| dish.rating.round end
      node(:thumbnail, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
        dish.photo.url(:thumb).split(ENV['S3_BUCKET']).last
      end
      node(:large, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
        dish.photo.url(:large).split(ENV['S3_BUCKET']).last
      end
      child :comments do
        attributes :id, :name, :description, :rating
      end
    end
    
    child :subsections do
      attributes :id, :name
      node(:mini, :unless => lambda {|s| s.photo_file_name.nil? }) do |subsection|
        subsection.photo.url(:mini).split(ENV['S3_BUCKET']).last
      end
      node(:thumbnail, :unless => lambda {|s| s.photo_file_name.nil? }) do |subsection|
        subsection.photo.url(:thumb).split(ENV['S3_BUCKET']).last
      end
      child :dishes do
        attributes :id, :name, :description, :price, :badge_name
        node(:rating, :unless => lambda {|d| d.rating.nil? }) do |dish| dish.rating.round end
        node(:thumbnail, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
          dish.photo.url(:thumb).split(ENV['S3_BUCKET']).last
        end
        node(:large, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
          dish.photo.url(:large).split(ENV['S3_BUCKET']).last
        end
        child :comments do
          attributes :id, :name, :description, :rating
        end
      end
    end
    
  end
  
end

