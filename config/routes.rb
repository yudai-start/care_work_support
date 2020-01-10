Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'users/registrations'
   }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "care_home_posts#index"
  # resources :family_posts
  resources :care_home_posts
  resources :users do
    member do
      get :family_room
      post :family_post
    end
  end
  

end
