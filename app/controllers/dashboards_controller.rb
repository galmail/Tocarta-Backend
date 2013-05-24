class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @dashboards = Dashboard.all
  end

  def show
    @dashboard = Dashboard.find params[:id]
  end
end
