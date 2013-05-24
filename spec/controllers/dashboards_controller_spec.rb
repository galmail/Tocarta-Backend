require 'spec_helper'

describe DashboardsController do

  describe "user access" do
      before :each do
        @user = create(:basic_user)
        @db   = create(:dashboard)
        sign_in(@user)
      end

    describe "GET #index" do

      it "renders index view" do
        get 'index'
        response.should be_success
        expect(response).to render_template :index
      end
      it "populate array of dashboards" do
        get :index
        expect(assigns(:dashboards)).to match_array [@db]
      end

    end

    describe "GET #show" do

      it "assigns requested @dashboard" do
        get 'show', id: @db
        response.should be_success
        expect(assigns(:dashboard)).to eq @db
      end
      it "renders show view" do
        get 'show', id: @db
        response.should be_success
        expect(response).to render_template :show
      end
    end

  end

  describe "anonymous access" do

    describe "GET #index" do
      it "requires login" do
        get :index
        # expect(response).to redirect_to new_user_session_path
        expect(response).to redirect_to "/users/sign_in"
      end
    end
    describe "GET #show" do
      it "requires login"
    end

  end

  describe "admin access" do

    describe "GET #index" do
      it "assigns requested @dashboard"
    end
    describe "GET #show" do
      it "renders show view"
    end

  end

end
