Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/dashboard' => "dashboard#index", :as => :dashboard_root
  # Defines the root path route ("/")
  # root "articles#index"
end
