# Adding all the columns to models

namespace :db do
	
	def fix_model(model,lines)
		puts "Fixing model #{model}."
		file_name = ''
		if model.include?('::')
			file_name = model.split("::").first.underscore << '/' << model.split("::").last.underscore
		else
			file_name = model.underscore
		end
		
		file_to_read = File.open("app/models/#{file_name}.rb","r")
		old_associations = []
		file_to_read.rewind
		file_to_read.readline #skipping the first one
		file_to_read.each {|line|
			break if line.start_with?("end")
			old_associations << line
		}
		file_to_read.close
		
		file_to_write = File.new("app/models/#{file_name}.rb", "w+")
		file_to_write.puts("class #{model} < ActiveRecord::Base")
		old_associations.each { |line| file_to_write.puts(line) }
		lines.each { |line| file_to_write.puts("\t#{line}") }
		file_to_write.puts("end")
		file_to_write.close
		
		puts "model #{model} fixed."
	end
	
	desc "Add Columns to Models"
	task :add_columns_to_models do
		action = 'rails generate migration' #rails generate active_scaffold
		
		# Chain
		sh "#{action} add_columns_to_chain email:string address:string note:text"
		fix_model('Chain',['attr_accessible :email, :address, :note'])
		
		# Restaurant
    sh "#{action} add_columns_to_restaurant manager:string email:string address:string phone:string note:text"
    fix_model('Restaurant',['attr_accessible :manager, :email, :address, :phone, :note'])
		
		# RestaurantSetting
		sh "#{action} add_columns_to_restaurant_setting num_licenses:integer default_language:string last_menu_sync:datetime"
		fix_model('RestaurantSetting',['attr_accessible :num_licenses, :default_language, :last_menu_sync'])
		
		# RestaurantActivity
    sh "#{action} add_columns_to_restaurant_activity ack:timestamp"
    fix_model('RestaurantActivity',['attr_accessible :ack'])
    
    # Table
    sh "#{action} add_columns_to_table number:integer status:string"
    fix_model('Table',['attr_accessible :number,:status'])
    
    # Tablet
    sh "#{action} add_columns_to_tablet active:boolean access_key:string display_size:string device_brand:string device_name:string device_os:string last_menu_sync:datetime"
    fix_model('Tablet',['attr_accessible :active, :access_key, :display_size, :device_brand, :device_name, :device_os, :last_menu_sync'])
		
		# MenuSetting
		sh "#{action} add_columns_to_menu_setting active:boolean priority:integer trigger_activation:datetime last_time_changed:datetime"
		fix_model('MenuSetting',['attr_accessible :active, :priority, :trigger_activation, :last_time_changed'])
		
		# Menu
		sh "#{action} add_columns_to_menu price:decimal menu_type:string"
		fix_model('Menu',['attr_accessible :price, :menu_type'])
		
		# Theme
    sh "#{action} add_columns_to_theme css:string description:text"
    fix_model('Theme',['attr_accessible :css, :description'])
		
		# Section
		sh "#{action} add_columns_to_section active:boolean position:integer"
    fix_model('Section',['translates :name, :fallbacks_for_empty_translations => true','attr_accessible :active, :position'])
    
    # Subsection
    sh "#{action} add_columns_to_subsection active:boolean position:integer"
    fix_model('Subsection',['translates :name, :fallbacks_for_empty_translations => true','attr_accessible :active, :position'])
    
    # Combo
    #sh "#{action} add_columns_to_combo active:boolean position:integer price:decimal description:text"
    #fix_model('Combo',['translates :name, :description, :fallbacks_for_empty_translations => true','attr_accessible :active, :position, :price, :description'])
    
    # ComboType
    sh "#{action} add_columns_to_combo_type active:boolean position:integer price:decimal description:text"
    fix_model('ComboType',['translates :name, :description, :fallbacks_for_empty_translations => true','attr_accessible :active, :position, :price, :description'])
		
		# Order
		sh "#{action} add_columns_to_order note:string"
    fix_model('Order',['attr_accessible :note'])
		
		# OrderItem
    sh "#{action} add_columns_to_order_item quantity:integer note:string"
    fix_model('OrderItem',['attr_accessible :quantity, :note'])
    
		# DishType
    sh "#{action} add_columns_to_dish_type position:integer dish_class:string"
    fix_model('DishType',['translates :name, :fallbacks_for_empty_translations => true','attr_accessible :position, :dish_class'])
    
    # DishTypeAssociation
		
		# Dish
    sh "#{action} add_columns_to_dish active:boolean position:integer description:text price:decimal rating:integer reviews:integer story:text video:string nutrition_facts:string"
    fix_model('Dish',['translates :name, :description, :story, :fallbacks_for_empty_translations => true','attr_accessible :active, :position, :description, :price, :rating, :reviews, :story, :video, :nutrition_facts'])
		
		# Comment
		sh "#{action} add_columns_to_comment description:text rating:integer approved:boolean"
		fix_model('Comment',['attr_accessible :description, :rating, :approved'])
		
		# SurveyQuestion
		sh "#{action} add_columns_to_survey_question description:text"
		fix_model('SurveyQuestion',['translates :name, :description, :fallbacks_for_empty_translations => true','attr_accessible :description'])
		
		# DishVariation
    sh "#{action} add_columns_to_dish_variation price:decimal"
    fix_model('DishVariation',['translates :name, :fallbacks_for_empty_translations => true','attr_accessible :price'])
		
		#sh 'rake db:migrate'
		
	end
	
	desc "Remove Columns from Models"
	task :remove_columns_to_models do
		action = 'rails destroy migration'
		sh "#{action} add_columns_to_chain"
		sh "#{action} add_columns_to_restaurant"
		sh "#{action} add_columns_to_restaurant_setting"
		sh "#{action} add_columns_to_restaurant_activity"
		sh "#{action} add_columns_to_menu"
		sh "#{action} add_columns_to_menu_setting"
		sh "#{action} add_columns_to_section"
		sh "#{action} add_columns_to_dish"
		sh "#{action} add_columns_to_dish_type"
		sh "#{action} add_columns_to_comment"
		sh "#{action} add_columns_to_comment_type"
		sh "#{action} add_columns_to_table"
		sh "#{action} add_columns_to_tablet"
		sh "#{action} add_columns_to_order"
		sh "#{action} add_columns_to_order_item"
		
		sh "#{action} add_columns_to_lf_Menu"
		sh "#{action} add_columns_to_lf_section"
		sh "#{action} add_columns_to_lf_dish"
		sh "#{action} add_columns_to_lf_dish_type"
		sh "#{action} add_columns_to_lf_order"
		sh "#{action} add_columns_to_lf_icon"
		sh "#{action} add_columns_to_lf_button"
		
	end

end

