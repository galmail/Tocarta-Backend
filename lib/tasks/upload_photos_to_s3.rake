# Upload Photos to S3
namespace :upload_photos do

  desc "Upload Chain Logos"
  task :chains => :environment do
    ###### Chain - Logo ######
    basedir = "test/img/chains"
    photos = Dir.new(basedir).entries
    photos.each{|photo|
      photo_location = basedir+"/"+photo
      if File.file?(photo_location)
        # get chain
        chain_id = photo.split(".")[0].split("_")[1]
        chain = Chain.find_by_id(chain_id)
        if !chain.nil?
          puts "uploading #{photo_location}"
          chain.logo = File.new(photo_location)
          chain.save
        end
      end
    }
  end
  
  desc "Upload Section Photos"
  task :sections => :environment do
    ###### Section - Photo ######
    basedir = "test/img/sections"
    photos = Dir.new(basedir).entries
    photos.each{|photo|
      photo_location = basedir+"/"+photo
      if File.file?(photo_location)
        # get section
        section_id = photo.split(".")[0].split("_")[1]
        section = Section.find_by_id(section_id)
        if !section.nil?
          puts "uploading #{photo_location}"
          section.photo = File.new(photo_location)
          section.save
        end
      end
    }
  end
  
  desc "Upload Dish Photos"
  task :dishes => :environment do
    ###### Dish - Photo ######
    basedir = "test/img/dishes"
    photos = Dir.new(basedir).entries
    photos.each{|photo|
      photo_location = basedir+"/"+photo
      if File.file?(photo_location)
        # get dish
        dish_id = photo.split(".")[0].split("_")[1]
        dish = Dish.find_by_id(dish_id)
        if !dish.nil?
          puts "uploading #{photo_location}"
          dish.photo = File.new(photo_location)
          dish.save
        end
      end
    }
  end

	desc "Upload All Photos to s3"
	task :all => :environment do
	  
	  ###### Chain - Logo ######
		basedir = "test/img/chains"
    photos = Dir.new(basedir).entries
    photos.each{|photo|
      photo_location = basedir+"/"+photo
      if File.file?(photo_location)
        # get chain
        chain_id = photo.split(".")[0].split("_")[1]
        chain = Chain.find_by_id(chain_id)
        if !chain.nil?
          puts "uploading #{photo_location}"
          chain.logo = File.new(photo_location)
          chain.save
        end
      end
    }
    
    ###### Section - Photo ######
    basedir = "test/img/sections"
    photos = Dir.new(basedir).entries
    photos.each{|photo|
      photo_location = basedir+"/"+photo
      if File.file?(photo_location)
        # get section
        section_id = photo.split(".")[0].split("_")[1]
        section = Section.find_by_id(section_id)
        if !section.nil?
          puts "uploading #{photo_location}"
          section.photo = File.new(photo_location)
          section.save
        end
      end
    }
    
    ###### Dish - Photo ######
    basedir = "test/img/dishes"
    photos = Dir.new(basedir).entries
    photos.each{|photo|
      photo_location = basedir+"/"+photo
      if File.file?(photo_location)
        # get dish
        dish_id = photo.split(".")[0].split("_")[1]
        dish = Dish.find_by_id(dish_id)
        if !dish.nil?
          puts "uploading #{photo_location}"
          dish.photo = File.new(photo_location)
          dish.save
        end
      end
    }
    
	end
	
end
