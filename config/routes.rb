Rails.application.routes.draw do

  root 'public/homes#top'
  get 'about' => 'public/homes#about'

  scope module: :public do
    resources :items,only: [:index,:show]

    resources :customers,only:[:edit,:update]
    get 'customers/my_page' => 'customers#show'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'

    get 'cart_items' => 'cart_items#index'

    resources :addresses,only:[:index,:create,:edit,:update,:destroy]
  end

  devise_for :customers

  namespace :admin do
    get 'sign_in' => 'devise/sessions#new'
    post 'sign_in' => 'devise/sessions#create'
    delete 'sign_out' => 'devise/sessions#destroy'

    get '' => 'homes#top'

    resources :genres,only: [:index,:create,:edit,:update]

    resources :items,only: [:index,:new,:create,:show,:edit,:update]
    resources :customers,only: [:index,:edit,:show,:update]
    resources :orders,only: [:index,:show,:update]
  end
end
