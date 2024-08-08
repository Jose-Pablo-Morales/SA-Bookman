Rails.application.routes.draw do
 
  root 'home#index'

  get 'home/index'
  resources :authors, only: [:index]
  resources :sales
  resources :reviews
  resources :books
  resources :authors

  get 'author_stats', to: 'author_stats#index'
  get 'top_selling_books', to: 'books#top_selling'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
