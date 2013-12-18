collection @order_items
attributes :quantity
glue :dish do
  attributes :id => :dish_id, :name => :item_name
  node :thumbnail do |dish|
    dish.photo.url(:thumb).split(ENV['S3_BUCKET']).last.split('?').first
  end
end


