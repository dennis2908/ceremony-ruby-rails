Rails.application.routes.draw do
  resources :bible_prayers, only: [:index, :new, :edit, :show, :create, :update]
  resources :groups do
    patch 'add_member', on: :member
    patch 'join', on: :member
    patch 'leave', on: :member
    resources :members, only: [:create]
    resources :group_comments
  end

  # patch '/groups/:id/add', to: 'groups#add', as: 'add_member'
  
  resources :prayers do
    resources :comments
  end

  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root to: "home#index"
  get '/home', to: 'home#landing', as: 'landing'
  # post '/prayers/:prayer_id/next', to: 'prayers#next', as: 'next_prayer'
  # post '/prayers/:prayer_id/previous', to: 'prayers#previous', as: 'previous_prayer'

  resources :users, only: [:show]
  
end
