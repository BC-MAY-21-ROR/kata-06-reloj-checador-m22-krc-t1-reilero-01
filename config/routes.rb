Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  resources :dashboard do 
    collection do 
      post :search
      get :search
    end
  end

  #dashboard routes
  get '/dashboard' => "dashboard#index", :as => :dashboard_root
  delete '/dashboard_delete/:id' => "dashboard#destroy", :as => :dashboard_delete
  get '/employee_create' => "dashboard#new"
  post '/employee_create' => "dashboard#create"
  get '/employee_edit/:id' => "dashboard#edit", :as => :employee_edit
  post '/employee_edit/:id' => "dashboard#update"
  get '/employee_show/:id' => "dashboard#show"
  get '/dashboard/search' => "dashboard#search"
  #store routes
  resources :stores

  post "private_number_input" => "home#private_number_input"

   
  # root "articles#index"
end
