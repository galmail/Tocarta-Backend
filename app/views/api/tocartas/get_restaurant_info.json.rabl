object false

### restaurant setting ###
node :name do @restaurant.restaurant_setting.name end
node :logo do @restaurant.chain.logo.url(:medium).split(ENV['S3_BUCKET']).last end

# child	@restaurant.restaurant_setting => :setting do
	# attributes :name, :default_language
# end

### restaurant menus ###

child @menus do
  object false
  attributes :id, :name, :menu_type
  
  child :sections do
    attributes :id, :name
    node(:mini, :unless => lambda {|s| s.photo_file_name.nil? }) do |section|
      section.photo.url(:mini).split(ENV['S3_BUCKET']).last
    end
    node(:thumbnail, :unless => lambda {|s| s.photo_file_name.nil? }) do |section|
      section.photo.url(:thumb).split(ENV['S3_BUCKET']).last
    end
    child :dishes do
      attributes :id, :name, :description, :price, :badge_name
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

