Rails.application.routes.draw do


  scope module: :public do

    root 'homes#top'
    get 'about' => 'homes#about'
    resources :items,only: [:index,:show]
    get 'customers/my_page' => 'customers#show'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers,only:[:edit,:update]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items,only:[:index,:create,:update,:destroy]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders,only: [:new,:create,:index,:show]
    resources :addresses,only:[:index,:create,:edit,:update,:destroy]

    devise_for :customers

  end


  namespace :admin do

    get '' => 'homes#top'
    resources :items,only: [:index,:new,:create,:show,:edit,:update]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :customers,only: [:index,:edit,:show,:update]
    resources :orders,only: [:index,:show,:update]
    resources :order_details,only: [:update]

  end

  devise_for :admin , module: 'admin'

end
