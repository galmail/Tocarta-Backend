class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :menu_for_current_user, only: [:index, :show]

  layout "dashboards/application"

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
      dishes = Dish.to_bottom_rating_hash_by_chain(params[:chain])
    else
      dishes = Dish.to_top_rating_hash_by_chain(params[:chain])
    end
    render :json => dishes
  end

  def chart_comments_by
    range = params[:range] ? params[:range] : 'month'

    comments = Restaurant.find(params[:restaurant]).comments.group_by_month(:created_at).count if range == 'month'
    comments = Restaurant.find(params[:restaurant]).comments.group_by_week(:created_at).count if range == 'week'
    comments = Restaurant.find(params[:restaurant]).comments.group_by_day(:created_at).count if range == 'day'

    render :json => comments
  end

  # This action is used to load remote content to comments widget
  def content_chart_comments_by
    # @dashboard  = Dashboard.find  params[:id]
    @restaurant = Restaurant.find params[:restaurant_id]
    @range      = params[:range]
    render layout: false
  end

  def chart_survey_comments_by
    range = params[:range] ? params[:range] : 'month'

    comments = Restaurant.find(params[:restaurant]).comments.with_survey.group_by_month('comments.created_at').count if range == 'month'
    comments = Restaurant.find(params[:restaurant]).comments.with_survey.group_by_week('comments.created_at').count if range == 'week'
    comments = Restaurant.find(params[:restaurant]).comments.with_survey.group_by_day('comments.created_at').count if range == 'day'

    render :json => comments
  end

  # FIXME: Here temporary, this must be in comments controller
  def approve_comment
    @comment = Comment.find params[:comment_id]
    @comment.approved = true
    if @comment.save
      respond_to do |format|
        format.js {render 'approve_comment'}
      end
    end
  end
  def reject_comment
    @comment = Comment.find params[:comment_id]
    @comment.approved = false
    if @comment.save
      respond_to do |format|
        format.js {render 'reject_comment'}
      end
    end
  end

  private

  def menu_for_current_user
    if current_user.has_role? :admin
      @chains     = Chain.all
    elsif current_user.has_role? :restaurant
      @chains     = current_user.chains
    elsif current_user.has_role? :distributor
    end
  end
end
