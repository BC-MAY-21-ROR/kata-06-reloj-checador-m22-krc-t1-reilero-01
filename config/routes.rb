Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins

  resource :dashboard, only: [:index] do 
    resources :employees, :stores
  end

  resources :employees
  
  get '/dashboard' => "dashboard#index", :as => :dashboard_root

  post "private_number_input" => "home#private_number_input"

   
end
