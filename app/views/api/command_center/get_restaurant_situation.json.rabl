### restaurant info ###

node :id do @restaurant.id end
node :name do @restaurant.name end
node :logo do @restaurant.chain.logo.url(:medium) end
node :num_tables do @restaurant.tables.length end

### restaurant activities ###

child @activities => 'activities' do
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
      attributes :quantity, :note, :name
      child :dish do
        attributes :name, :description, :price
      end
      child :combo do
        attributes :name, :price
        child :dishes do
          attributes :name, :description, :price
        end
      end
    end
  end
end
