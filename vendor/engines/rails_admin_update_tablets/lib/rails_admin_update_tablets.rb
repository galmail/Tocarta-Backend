require "rails_admin_update_tablets/engine"
require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminUpdateTablets
end
 
module RailsAdmin
  module Config
    module Actions
      class UpdateTablet < RailsAdmin::Config::Actions::Base
        
        RailsAdmin::Config::Actions.register(self)
        
        register_instance_option :bulkable? do
          true
        end
        
        register_instance_option :visible? do
          authorized? && !bindings[:object].active?
        end
        
        register_instance_option :member? do
          true
        end
        
        register_instance_option :link_icon do
          'icon-upload'
        end
        
        register_instance_option :controller do
          Proc.new do
            if !@object.nil?
              puts "Updating tablet with id: " + @object.id.to_s
              @object.send_update_notification
            else
              @objects = list_entries(@model_config, :destroy)
              # Update field published to true
              @objects.each do |object|
                puts "Updating tablet with id: " + object.id.to_s
                object.send_update_notification
              end
            end
            flash[:notice] = "Push Notification Update Sent. Updates usually take 2 minutes for changes to take effect."
            redirect_to back_or_index
          end
        end
        
      end
    end
  end
end
