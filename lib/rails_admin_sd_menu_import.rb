# encoding: UTF-8

require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

# module RailsAdminSdMenuImport
# end

module RailsAdmin
  module Config
    module Actions
      class SdMenuImport < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        # Only if @restuarant have location defined
        register_instance_option :visible? do
          puts "**********  #{bindings[:controller]}"
          authorized? && bindings[:abstract_model].model.to_s == "Restaurant" && bindings[:object].sd_location_id
        end

        register_instance_option :member? do
          true
        end

        register_instance_option :link_icon do
          'icon-cloud-download'
        end

        register_instance_option :controller do
          Proc.new do
            if !@object.nil?
              @object.import_sd_menu!
              flash[:notice] = "Menú importado."
            else
              flash[:error] = "Problema importando."
            end
            redirect_to back_or_index
          end
        end
      end
    end
  end
end
