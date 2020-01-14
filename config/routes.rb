Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
   }

  root to: "care_home_posts#index"
  resources :care_home_posts, only: [:index, :create]
  resources :users, only: [:index]
  resources :family_rooms, only: [:index] do
    resources :family_posts, only: [:index, :create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
