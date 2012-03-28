collection @tablets
  attributes :id, :name, :active, :access_key, :alive
  node :is_alive do |tablet|
    (!tablet.alive.nil? and tablet.alive > @now)
  end
