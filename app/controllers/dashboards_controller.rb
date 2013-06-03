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

  def chart_newest_comments_on_dishes
    comments = Restaurant.find(params[:restaurant]).comments.with_dish.newest
    render :json => {
      :type => 'ColumnChart',
      :cols => [['string', 'Dish'], ['number', 'Average'], ['number', 'Last'], ['number', 'Comments']],
      :rows => Comment.to_dish_rating_array(comments),
      :options => {
        chartArea: { width: '90%', height: '75%' },
        seriesType: 'bars',
        series: {2 => {type: 'line'}},
        # :hAxis => { title: 'dish' },
        # vAxis: { title: 'Rating' },
        legend: 'bottom',
        is3D: true,
        # animation: { duration: 1000 },
      }
    }
  end
  def chart_top_dishes
    if params[:reverse]
      dishes = Dish.to_bottom_rating_array_by_chain(params[:chain])
    else
      dishes = Dish.to_top_rating_array_by_chain(params[:chain])
    end
    render :json => {
      :type => 'ColumnChart',
      :cols => [['string', 'Dish'], ['number', 'Average'], ['number', 'Comments']],
      :rows => dishes,
      :options => {
        chartArea: { width: '80%', height: '75%' },
        seriesType: 'bars',
        series: {1 => {type: 'line'}},
        :hAxis => { title: 'dish' },
        legend: 'bottom',
      }
    }
  end

  private

  def menu_for_current_user
    if current_user.has_role? :admin
      @chains     = Chain.all
    elsif current_user.has_role? :restaurant
      @chains     = Chain.all
    elsif current_user.has_role? :distributor
    end
  end
end
