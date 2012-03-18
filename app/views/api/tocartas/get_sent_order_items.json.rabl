collection @order_items
attributes :quantity
child :dish do |item|
  attributes :id, :name, :price
  node(:thumbnail, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
    dish.photo.url(:thumb)
  end
  node(:photo, :unless => lambda {|d| d.photo_file_name.nil? }) do |dish|
    dish.photo.url(:medium)
  end
end
