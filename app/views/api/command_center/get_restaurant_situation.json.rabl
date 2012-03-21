object false

### restaurant info ###

node :id do @restaurant.id end
node :name do @restaurant.name end
node :logo do @restaurant.chain.logo.url(:medium).split(ENV['S3_BUCKET']).last end
node :num_tables do @restaurant.tables.length end

### restaurant activities ###

child @activities do
  object false
  attributes :id, :name, :ack
  node :table_number do |activity|
    activity.table_number
  end
  node :date do |activity|
    activity.date
  end
  child :order do
    attributes :id, :total
    node :table do |order|
      order.table.number
    end
    child :order_items do
      attributes :quantity, :note
      node :item_name do |order_item|
        order_item.dish.name
      end
      child :dish do
        attributes :name, :description, :price
      end
    end
  end
end