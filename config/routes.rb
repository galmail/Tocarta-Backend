TocartaAdmin::Application.routes.draw do

  api_version(:module => "V1", :path => {:value => "v1"}, :defaults => {:format => "json"}, :default => true) do
    #resources :pruebas
    match 'cli/c/:action(.:format)', :controller => 'Tocartas'
    match 'cli/mw/:action(.:format)', :controller => 'MeWaiter'
    match 'cli/r/:action(.:format)', :controller => 'CommandCenter'
    match 'cli/sd/:action(.:format)', :controller => 'Subtledata'
    match 'legal(/:action)', :controller => 'Legal'
  end

  api_version(:module => "V2", :path => {:value => "v2"}, :defaults => {:format => "json"}) do
    #resources :pruebas
    match 'cli/c/:action(.:format)', :controller => 'Tocartas'
    match 'cli/mw/:action(.:format)', :controller => 'MeWaiter'
    match 'cli/r/:action(.:format)', :controller => 'CommandCenter'
    match 'cli/sd/:action(.:format)', :controller => 'Subtledata'
    match 'legal(/:action)', :controller => 'Legal'
  end

  match "/import/:restaurant_id" => "importsd#index"
  match "/import/:restaurant_id/go" => "importsd#import"
  
  match "/setup" => "setupMenu#index"
  match "/setup/go" => "setupMenu#setup"

  match "/dashboards(/:action(.:format))" => "Dashboards", :as => :dashboards
  match "/dashboards/:id/:restaurant_id" => "dashboards#show"
  # Necesary for remote load of tabs on comments widget
  match "/dashboards/:id/:restaurant_id/content_chart_comments_by/:range" => "dashboards#content_chart_comments_by"

  get "authentications/create"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount RailsAdminImport::Engine => '/rails_admin_import', :as => 'rails_admin_import'

  # Use custom controller
  devise_for :users, :controllers => {:registrations => "users/registrations",:sessions => "users/sessions"}
  match '/auth/:provider/callback' => 'authentications#create'
  
  # match "login(.:format)", :controller => 'Users::Sessions', :action => 'create'
  # match "logout(.:format)", :controller => 'Users::Sessions', :action => 'destroy'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => "rails_admin::Main#dashboard"
  
  # API for Tocartas
  match 'api(/:action)', :controller => 'Api'
  match 'ftp(/:action)', :controller => 'Ftp'
  match 'uml(/:action)', :controller => 'uml'
  
  # Twitter and Facebook
  #match '/cli/c/twitter/:action(.:format)', :controller => 'Twitter'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  # match ':controller(/:action(/:id(.:format)))'

end
