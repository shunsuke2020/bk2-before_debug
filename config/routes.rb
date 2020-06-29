Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books
  resources :users,only:[:show,:edit,:update]
 root 'layouts#top'
 get 'users' => 'users#index'
 get 'home/about' => 'layouts#about'
delete '/books' => 'books#destroy'
end


