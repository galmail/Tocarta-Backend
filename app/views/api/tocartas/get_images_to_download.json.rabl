collection @images

node(:thumb) do |item|
  item.photo.url(:thumb)
end
node(:thumb_dest) do |item|
  item.photo.url(:thumb).split(ENV['S3_BUCKET']).last.split('?').first
end

node(:medium) do |item|
  item.photo.url(:medium)
end
node(:medium_dest) do |item|
  item.photo.url(:medium).split(ENV['S3_BUCKET']).last.split('?').first
end
