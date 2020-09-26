Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      ##user routes
      post '/users/auth/signup', to: 'users#signup'
      post '/users/auth/signin', to: 'users#signin'

      get 'users', to: 'users#index'
      get 'users/profile', to: 'users#profile'
      delete 'users/:id', to: 'users#destroy'

      ##post routes
      get 'posts', to: 'posts#all_posts'
      get 'posts/:id', to: 'posts#show'
      post 'posts/new', to: 'posts#create'
      delete 'posts/:id', to: 'posts#destroy'

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
