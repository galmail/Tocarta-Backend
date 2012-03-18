object false

### restaurant setting ###

child	@restaurant.restaurant_setting => :setting do
	attributes :name, :default_language
end

### restaurant menus ###

child @menus do
  object false
  attributes :id, :name, :menu_type
  
  child :sections do
    attributes :id, :name
    node(:photo, :unless => lambda {|s| s.photo_file_name.nil? }) do |section|
      section.photo.url(:thumb)
    end
    child :dishes do
      attributes :id, :name
      node(:thumbnail, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
        dish.photo.url(:thumb)
      end
      node(:photo, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
        dish.photo.url(:medium)
      end
      child :comments do
        attributes :id, :name, :description, :rating
      end
    end
    
    child :subsections do
      attributes :id, :name
      node(:thumbnail, :unless => lambda {|s| s.photo_file_name.nil? }) do |subsection|
        subsection.photo.url(:thumb)
      end
      node(:photo, :unless => lambda {|s| s.photo_file_name.nil? }) do |subsection|
        subsection.photo.url(:medium)
      end
      child :dishes do
        attributes :id, :name
        node(:thumbnail, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
          dish.photo.url(:thumb)
        end
        node(:photo, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
          dish.photo.url(:medium)
        end
        child :comments do
          attributes :id, :name, :description, :rating
        end
      end
    end
    
  end
  
end

