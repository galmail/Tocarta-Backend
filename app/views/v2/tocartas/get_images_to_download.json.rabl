collection @images

### any size ###
node :source do |pic|
  pic
end
node :dest do |pic|
  pic.split(ENV['S3_BUCKET']).last.split('?').first
end
