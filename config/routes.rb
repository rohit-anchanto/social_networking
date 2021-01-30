Rails.application.routes.draw do
  devise_for :users
  root 'welcome#home'
  get 'users/:user_id/friends',to: "users#friends",as: 'user_friends'
  get 'users/:user_id/pendingrequests',to: "users#pendingrequests",as: 'user_pending_request'
  get 'users/:user_id/receievedrequests',to: "users#receievedrequests",as: 'user_receieved_request'
  get 'my_profile', to: 'users#my_profile'
  post 'users/accept_request/:user_id', to: "friendships#accept",as: 'accept_request'
  resources:users, only: [:index, :show, :destroy] do
    resources:friendships
  end  
  resources :comments
  resources:posts do
    resources:likes
    resources:comments do
      resources:likes
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
