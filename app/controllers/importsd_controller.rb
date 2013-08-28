class ImportsdController < ApplicationController
  before_filter :authenticate_user!

  layout "application"

  # This action displays a nice simple web with the "Import Menu" button.
  def index
    @restaurant_id = 0
    if !current_user.has_role? :admin
      flash[:error] = "You don't have permission to run this action!"
    else
      @restaurant = Restaurant.find_by_id(params[:restaurant_id])
      if @restaurant.nil? or @restaurant.chain.nil? or @restaurant.chain.user.nil? or @restaurant.chain.user.id != current_user.id
        flash[:error] = "This URL is broken! Please contact support."
      else
        @restaurant_id = @restaurant.id
      end
    end
  end

  # This action import the menu 
  def import
    flash[:success] = "The menu was imported successfully!"
    @restaurant = Restaurant.find params[:restaurant_id]
    @restaurant.import_sd_menu!
  end

end