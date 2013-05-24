class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @dashboards = Dashboard.all
  end

  def show
    @dashboard = Dashboard.find params[:id]
    restaurant = Restaurant.find 1
    @newest_comments_on_dishes = restaurant.comments.with_dish.newest
  end
end
