child @floors do
  attributes :id, :sid, :name
  child :tables => :tables do
    attributes :id, :sid, :number
  end
end
