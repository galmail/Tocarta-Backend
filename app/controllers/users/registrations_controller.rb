class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :get_rol

  def new
    super
  end

  def create
    #super
    build_resource

    if resource.save
      resource.add_role @rol.to_sym unless @rol == 'admin'

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

  def thanks
    
  end

  protected

  # def after_sign_up_path_for(resource)
    # '/an/example/path'
  # end
  # After new user is created we send it to a non-protected view, so flash can be shown
  def after_inactive_sign_up_path_for(resource)
    '/users/sign_in'
  end

  private

  # Get role from params
  def get_rol
    @rol = params['user'].delete('rol') unless params['user'].nil?
  end
end
