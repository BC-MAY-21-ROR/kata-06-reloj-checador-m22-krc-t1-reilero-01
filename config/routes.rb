Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  resources :dashboard

  #dashboard routes
  get '/dashboard' => "dashboard#index", :as => :dashboard_root
  get '/employee_create' => "dashboard#new"
  post '/employee_create' => "dashboard#create"
  get '/employee_edit/:id' => "dashboard#edit", :as => :employee_edit
  post '/employee_edit/:id' => "dashboard#update"
  get '/employee_show/:id' => "dashboard#show"

  #store routes
  resources :stores

  post "parse_input" => "home#parse_input"

   
  # root "articles#index"
end
