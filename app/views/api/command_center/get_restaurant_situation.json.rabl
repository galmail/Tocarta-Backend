object false

### restaurant info ###

node :name do @restaurant.name end
node :logo do @restaurant.chain.logo.url(:medium).split(ENV['S3_BUCKET']).last end
node :num_tables do @restaurant.tables.length end

### restaurant activities ###

child @activities do
  object false
  attributes :id, :name, :ack
  node :table_number do |activity|
    activity.table.number
  end
  node :date do |activity|
    ChronicDuration.output((Time.now.round - activity.created_at.round).to_i, :format => :short)
  end
  child :order do
    attributes :id, :total
    node :table do |order|
      order.table.number
    end
    child :order_items do
      attributes :quantity, :note
      child :dish do
        attributes :name, :description, :price
      end
    end
  end
end