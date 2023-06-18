Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # get 'book/index'
      # get 'articles/index'
      # get 'articles/show'
      # get 'articles/create'
      # get 'articles/update'
      # get 'articles/destroy'
      # resources: articles, only: [:index. :show, :create, :update, :destroy]
      resources :books, only: [:index, :create, :destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
