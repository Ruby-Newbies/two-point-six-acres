Rails.application.routes.draw do


  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :create, :show, :update, :destroy]
      resources :comments, only: [:index, :create, :show, :destroy]
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :follows, only: [:index, :create, :destroy]
      resources :likes, only: [:create]
      resources :sections, only: [:index, :show, :create, :destroy]
      resources :usermails, only: [:index, :create, :show, :update]
      post '/authentication/login', to: 'authentication#login'
      get '/authentication/test', to: 'authentication#test'
      get '/follows/isFollowed', to: 'follows#isFollowed'
      post '/authentication/admin/login', to: 'authentication#adminlogin'
      get '/likes/count', to: 'likes#countLikes'
      get '/likes/liked', to: 'likes#liked'
      # resources :microposts, only: [:index, :create, :show, :update, :destroy]
      # resources :sessions, only: [:create]
      # scope path: '/user/:user_id' do
      #   resources :microposts, only: [:index]
      end
    end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
