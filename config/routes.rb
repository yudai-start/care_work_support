Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'users/registrations'
   }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "care_home_posts#index"
  resources :care_home_posts
  resources :users
  resources :family_rooms do
    resources :family_posts
  end
end
