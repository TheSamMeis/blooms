Bloom::Application.routes.draw do
  
  get "recurly/billing"
  get "recurly/account"
  post "recurly/push"
  get "recurly/test"
  get "recurly/test_new_subscription"
  post "recurly/push_new_subscription"
  get "recurly/test_declined_payment"
  post "recurly/push_declined_payment"
  get "recurly/test_successful_payment"
  post "recurly/push_successful_payment"

  get "session/new"
  resources :users
  resources :checkouts
  resources :session
  resources :ship_addresses
  resources :user_orders
  resources :subscriptions
  resources :products

   get 'export' => 'subscriptions#export'
   post 'export' => 'subscriptions#export_action'

   get 'export_action' =>'subscriptions#export_action'
   get 'update' => 'subscriptions#update_ship_dates'
   get 'all/dashboard' =>  'subscriptions#index'
   get 'active/dashboard' =>  'subscriptions#index_active'
   get 'update_ship'=> 'subscriptions#edit_ship_address'
   post 'update_ship'=> 'subscriptions#update_ship_address'


  get "site/index" 
  get "site/privacy"
  get "site/terms"

  root 'site#index'
  
  get 'dashboard' => 'subscriptions#index_active'

  get 'signup' =>  "users#new"
  delete 'logout' => "session#destroy"
  get "logout" => "session#destroy"

  post 'users/new' => "users#create"
  post 'session/new' => 'session#create'

  get 'flowers' => 'site#subscribe'
  post 'site/subscribe' => 'site#subscribe_create'

  get 'registration' => 'recurly#billing'
  get 'registrations/new'


end
