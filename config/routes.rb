Rails.application.routes.draw do

  devise_for :brandusers, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
  
  resources :brandusers do
    collection do
      get 'authenticate'
    end
  end
  resources :instausers 
 

  resources :messages do
    collection do 
      get 'list'
    end
  end
  # patch '/publish' => 'messages#publish'
     
  root 'pages#home'
   get '/pages/terms' => 'pages#terms'
  get '/faq' => 'pages#faq'
   get 'pages/faq' => 'pages#faq'
  get '/pages/about' => 'pages#about'
  get '/instagrammers' => 'pages#instagrammers'
  get '/instagramers' => 'pages#instagramers'
  get '/influencers' => 'pages#influencers'
  get '/myinstagram' => 'pages#myinstagram'
  get '/pages/contact' => 'pages#contact'
  get '/pages/logout' => 'pages#logout'
  post '/pages/search' => 'pages#search'
  get '/pages/search' => 'pages#search'
  get '/pages/age'=>'pages#age'
  get '/detail/:id' => 'charges#detail', as: :detail
  patch '/pages/results' => 'pages#results'
  get '/welcome' => 'pages#welcome'
  get '/brandwaitlist' => 'pages#brandwaitlist'
  get 'pages/brandwaitlist' => 'pages#brandwaitlist'
  get'/pages/home' => 'pages#home'
  get 'pages/logout2'=> 'pages#logout2'  
  get 'profile/:id' => 'brandusers#profile', as: :profile
  get 'pages/testmarketing' => 'pages#testmarketing'

  resources :charges do
    collection do
      get 'list'
    end
    member do
      patch 'accept'
      patch 'decline'
      patch 'release_request'
      patch 'complete'
      post 'gbill'
    end
  end

  get '/pages/verification' => 'pages#verification'
  get '/privacy' => 'pages#privacy'
  get '/pages/privacy' => 'pages#privacy'
  get '/brands'=> 'instausers#brands'
  get '/contact-brands' => 'instausers#brands_contact_form' , as: :brands_contact_form
  get '/bsignup' => 'brandusers#new'
  get '/blogin' => 'sessions#new' 
  post '/blogin' => 'sessions#create'
  delete '/blogout' => 'sessions#destroy'
  get '/bdashboard' => 'brandusers#dashboard'
  get '/message-brands' => 'instausers#formmessage' , as: :formmessage
    
  get '/auth' => 'instausers#auth'
  get '/signup' => 'instausers#signup'
  get '/newuser' => 'instausers#new'  
  get '/callback' => 'instausers#callback'
  get '/dashboard' => 'instausers#dashboard' 
  get 'login' => 'instausers#auth'
  delete '/logout' => 'sessions#destroy'
   
  get '/checkin' => 'instausers#checkin'
  post '/search' => 'instausers#search'
delete '/destroy/:id' => 'instausers#destroy' , as: :destroy 
  get '/cities' => 'application#cities'
patch 'destroy/:id'=> 'instausers#destroy'
 

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
 
