Rails.application.routes.draw do
  
 
  devise_for :users
  root 'pages#home'  
   
   get 'bsignup' => 'brandusers#new'
   get '/blogin' => 'sessions#new' 
   post 'blogin' => 'sessions#create'
   delete '/blogout' => 'sessions#destroy'
   get '/bdashboard' => 'brandusers#dashboard'
   resources :brandusers

  resources :instausers 
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'
  get '/auth' => 'instausers#auth'
  get '/signup' => 'instausers#signup'
  get '/newuser' => 'instausers#new'  
  get '/callback' => 'instausers#callback'
  get '/dashboard' => 'instausers#dashboard' 
  get 'login' => 'instausers#auth'
  get '/about' => 'pages#about'
  delete '/logout' => 'sessions#destroy'
  get 'pages/logout' => 'pages#logout'
  get '/checkin' => 'instausers#checkin'
   
end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
 
