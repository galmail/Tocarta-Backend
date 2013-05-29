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

  def col_chart
    comments = Restaurant.find(params[:restaurant]).comments.with_dish.newest
    render :json => {
      :type => 'ColumnChart',
      :cols => [['string', 'Dish'], ['number', 'Average'], ['number', 'Last']],
      :rows => Comment.to_dish_rating_array(comments),
      :options => {
        chartArea: { width: '90%', height: '75%' },
        # :hAxis => { title: 'dish' },
        # vAxis: { title: 'Rating' },
        legend: 'bottom',
        is3D: true,
        # animation: { duration: 1000 },
      }
    }
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
