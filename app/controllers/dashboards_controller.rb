class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :menu_for_current_user, only: [:index, :show]

  def index
    @dashboard  = Dashboard.first # FIXME: search for a name?
  end

  def show
    @dashboard  = Dashboard.find  params[:id]
    @restaurant = Restaurant.find params[:restaurant_id]
  end

  private

  def menu_for_current_user
    if current_user.has_role? :admin
      @chains     = Chain.all
    elsif current_user.has_role? :restaurant
    elsif current_user.has_role? :distributor
    end
  end
end
