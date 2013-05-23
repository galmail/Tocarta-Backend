require 'spec_helper'

describe DashboardsController do

  describe "GET #index" do
    it "returns http success" do
      get 'index'
      response.should be_success
      expect(response).to render_template :index
    end
    it "populate array of dashboards" do
      db = create(:dashboard)
      get :index
      expect(assigns(:dashboards)).to match_array [db]
    end
  end

  describe "GET #show" do
    # it "returns http success" do
      # response.should be_success
    # end
    it "assigns requested @dashboard" do
      db = create(:dashboard)
      get 'show', id: db
      response.should be_success
      expect(assigns(:dashboard)).to eq db
    end
    it "renders show view" do
      db = create(:dashboard)
      get 'show', id: db
      expect(response).to render_template :show
    end
  end

end
