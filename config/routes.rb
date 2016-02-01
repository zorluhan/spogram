Rails.application.routes.draw do
  
resources :brandusers
resources :instausers 
resources :messages 

  root 'pages#home'
  get '/pages/about' => 'pages#about'
  get '/pages/contact' => 'pages#contact'
  get '/pages/logout' => 'pages#logout'
  post '/pages/search' => 'pages#search'
  get '/pages/search' => 'pages#search'
  get '/pages/age'=>'pages#age'
  patch '/pages/results' => 'pages#results'
  get '/pages/form' => 'pages#form'
  get 'charges/new' => 'charges#new'
  post '/charges/new' => 'charges#create'
  get '/charges/bill' => 'charges#bill'
  get 'charges/billed' => 'charges#billed'
  patch '/publish' => 'messages#publish'
  patch '/charges/publish_proposal' => 'charges#publish_proposal', as: :publish_proposal
  get '/charges' => 'charges#index'
  get 'charges/:id'=>'charges#show', :as => 'charge'
  post 'charges/bill' => 'charges#bill'
  post '/charges' => 'charges#create'
 
   # get '/bsignup' => 'brandusers#new'
   get '/blogin' => 'sessions#new' 
   post '/blogin' => 'sessions#create'
   delete '/blogout' => 'sessions#destroy'
   get '/bdashboard' => 'brandusers#dashboard'
   

  get '/auth' => 'instausers#auth'
  get '/signup' => 'instausers#signup'
  get '/newuser' => 'instausers#new'  
  get '/callback' => 'instausers#callback'
  get '/dashboard' => 'instausers#dashboard' 
  get 'login' => 'instausers#auth'
  
  delete '/logout' => 'sessions#destroy'
  get '/checkin' => 'instausers#checkin'
  post '/search' => 'instausers#search'

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
 
