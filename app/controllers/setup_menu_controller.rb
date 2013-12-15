class SetupMenuController < ApplicationController
  
  #before_filter :authenticate_user!

  layout "application"

  # This action displays a nice simple web with the "Import Menu" button.
  def index
    
  end

  # This action setup the menu
  def setup
    url = params[:gsmenu]
    key = CGI.parse(URI.parse(url).query)["key"][0]
    session = GoogleDrive.login("gal@tocarta.es", "na0mieitanic0")
    gsmenu = session.spreadsheet_by_key(key)
    
    ######## Restaurants ########
    p "Setting up Restaurants"
    csv = gsmenu.export_as_string('csv',0)
    setup = {
      #:authenticity_token => "wb8vQPRjpK+eeF4X0Os2e97FvUlE1UMC+eE+5dK3WiI=",
      :csv_string => "#{csv}",
      :update_if_exists => 1,
      :update_lookup => "name",
      :user => "email",
      :chain => "name"
    }
    Restaurant.run_import(setup)
    
    ######## Waiters ########
    p "Setting up Waiters"
    csv = gsmenu.export_as_string('csv',1)
    setup = {
      :csv_string => "#{csv}",
      :update_if_exists => 1,
      :update_lookup => "key",
      :restaurant => "name"
    }
    Waiter.run_import(setup)
    
    ######## Payments ########
    p "Setting up Payments"
    csv = gsmenu.export_as_string('csv',2)
    setup = {
      :csv_string => "#{csv}",
      :update_if_exists => 1,
      :update_lookup => "key",
      :restaurant => "name"
    }
    Payment.run_import(setup)
    
    ######## Printers ########
    p "Setting up Printers"
    csv = gsmenu.export_as_string('csv',3)
    setup = {
      :csv_string => "#{csv}",
      :update_if_exists => 1,
      :update_lookup => "sid",
      :restaurant => "name"
    }
    Printer.run_import(setup)
    
    ######## Floors ########
    p "Setting up Floors"
    csv = gsmenu.export_as_string('csv',4)
    setup = {
      :csv_string => "#{csv}",
      :update_if_exists => 1,
      :update_lookup => "sid",
      :restaurant => "name",
      :printer => "sid"
    }
    Floor.run_import(setup)
    
    ######## Tables ########
    p "Setting up Tables"
    csv = gsmenu.export_as_string('csv',5)
    setup = {
      :csv_string => "#{csv}",
      #:update_if_exists => 0,
      :restaurant => "name",
      :floor => "sid"
    }
    Table.run_import(setup)
    
    ######## Menus ########
    p "Setting up Menus"
    csv = gsmenu.export_as_string('csv',6)
    setup = {
      :csv_string => "#{csv}",
      :update_if_exists => 1,
      :update_lookup => "sid",
      :restaurant => "name",
      :printer => "sid"
    }
    Menu.run_import(setup)
    
    ######## MenuSettings ########
    p "Setting up MenuSettings"
    csv = gsmenu.export_as_string('csv',7)
    setup = {
      :csv_string => "#{csv}",
      :update_if_exists => 0,
      :menu => "sid"
    }
    MenuSetting.run_import(setup)
    
    ######## Sections ########
    p "Setting up Sections"
    csv = gsmenu.export_as_string('csv',8)
    setup = {
      :csv_string => "#{csv}",
      :update_if_exists => 1,
      :update_lookup => "sid",
      :menu => "sid",
      :printer => "sid"
    }
    Section.run_import(setup)
    
    
    
    flash[:success] = "Setup Done"
    
  end
  
end
