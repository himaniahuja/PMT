PMT::Application.routes.draw do

  get "home/home"

  devise_for :users , :controllers => {:registrations => 'user_registration'}

  match 'users/:id' => 'users#show', :as => 'profile'

  get "pages/home"

  root :to => "home#home"
  match 'pages/showall' => 'pages#showall'
  match 'pages/showmy' => 'pages#showmy'

  match 'home' => 'home#home'
  match 'home/update_phase_select' => 'home#update_phase_select'
  match 'home/update_deliverable_select' => 'home#update_deliverable_select'

  resources :projects do
    member do
      post 'archive'
    end
  end
  resources :phases

  resources :deliverables do
    member do
      post 'toggle_is_done'
    end

    match 'estimations' => 'estimations#edit'
    match 'estimations/update' => 'estimations#update', :via => :put
    match 'estimations/dropdown_update' => 'estimations#dropdown_update'
  end

  resources :efforts

  match 'projects/dropdown_update' => 'projects#dropdown_update' ,:via => :post
  match 'deliverables/dropdown_update' => 'deliverables#dropdown_update' ,:via => :post
  match 'home/update_effort' => 'home#update_effort' ,:via => :post
  match 'update_effort' => 'home#update_effort' ,:via => :post

  resources :deliverable_types

  match 'pages/search_update' => 'pages#search_update', :via => :post

  #match 'estimations/:deliverable_id' => 'estimations#index'
  #match 'estimations' => 'estimations#create', :via => :post
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
