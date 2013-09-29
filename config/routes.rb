TocartaAdmin::Application.routes.draw do

  match "/import/:restaurant_id" => "importsd#index"
  match "/import/:restaurant_id/go" => "importsd#import"

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
  match 'cli/c/:action(.:format)', :controller => 'Api::Tocartas'
  match 'cli/r/:action(.:format)', :controller => 'Api::CommandCenter'
  # match 'cli/an/:action(.:format)', :controller => 'Api::Analytics'
  match 'cli/sd/:action(.:format)', :controller => 'Api::Subtledata'
  match 'cli/mw/:action(.:format)', :controller => 'Api::MeWaiter'
  match 'legal(/:action)', :controller => 'Api::Legal'
  match 'uml(/:action)', :controller => 'uml'
  
  # Twitter and Facebook
  #match '/cli/c/twitter/:action(.:format)', :controller => 'Twitter'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  # match ':controller(/:action(/:id(.:format)))'

end
