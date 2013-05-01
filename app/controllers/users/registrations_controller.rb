class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :get_rol

  def new
    super
  end

  def create
    #super
    build_resource

    if resource.save
      resource.add_role @rol.to_sym
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    super
  end

  private

  # Get role from params
  def get_rol
    @rol = params['user'].delete('rol') unless params['user'].nil?
  end
end
