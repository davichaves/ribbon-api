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

      post 'posts/:id/like', to: 'posts#like'

      ##comments routes
      get 'comments/post/:id', to: 'comments#post_comments'
      get 'comments/:id', to: 'comments#show'
      post 'comments/new/post/:id', to: 'comments#create'
      delete 'comments/:id', to: 'comments#destroy'

      post 'comments/:id/like', to: 'comments#like'

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
