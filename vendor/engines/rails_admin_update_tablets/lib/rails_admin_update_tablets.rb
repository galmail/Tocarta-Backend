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
            @object.send_update_notification
            flash[:notice] = "Push Notification Update Sent."
            redirect_to back_or_index
          end
        end
        
      end
    end
  end
end
