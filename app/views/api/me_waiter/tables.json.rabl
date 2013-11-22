child @floors do
  attributes :id, :sid, :name
  
  node(:printer_id, :unless => lambda {|f| f.printer.nil? }) do |floor|
    floor.printer.number
  end
  
  child :tables => :tables do
    attributes :id, :sid, :number
  end
end
