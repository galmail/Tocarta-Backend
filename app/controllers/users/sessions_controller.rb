class Users::SessionsController < Devise::SessionsController
  before_filter :authenticate_user!, :except => [:create, :destroy]

  def create
    email = params[:email]
    password = params[:password]
    if !params[:user].nil?
      email = params[:user][:email]
      password = params[:user][:password]
    end
    
    resource = User.find_for_database_authentication(:email => email)
    return invalid_login_attempt unless resource

    if resource.valid_password?(password)
      sign_in(:user, resource)
      #resource.ensure_authentication_token!
      resource.reset_authentication_token!
      respond_to do |format|
        format.xml  { render :xml => {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email} }
        format.json  { render :json => {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email} }
        format.html { redirect_to root_url }
      end
      return
    end
    invalid_login_attempt
  end

  def destroy
    resource = User.find_for_database_authentication(:email => params[:email])
    if params[:email].nil?
      resource = current_user
    end
    sign_out(resource)
    resource.authentication_token = nil
    resource.save
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { render :json => {:success=>true} }
      format.xml  { render :xml  => {:success=>true} }
    end
  end

  protected

  def invalid_login_attempt
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
  
end
