Rails.application.routes.draw do


  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'

    resources :items,only: [:index,:show]

    get 'customers/sign_up' => 'registrations#new'

    get 'customers/sign_in' => 'sessions#new'

    get 'customers/my_page' => 'customers#show'
    resources :customers,only:[:edit,:update]
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'

    resources :cart_items,only:[:index,:create,:update,:destroy]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'

    resources :orders,only: [:new,:create,:index,:show]

    resources :addresses,only:[:index,:create,:edit,:update,:destroy]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
  end
  post 'customers/sign_in' => 'devise/sessions#create' ,as: "customer_session"

  devise_for :customers

  namespace :admin do
    get 'sign_in' => 'sessions#new'

    get '' => 'homes#top'

    resources :items,only: [:index,:new,:create,:show,:edit,:update]

    resources :genres,only: [:index,:create,:edit,:update]

    resources :customers,only: [:index,:edit,:show,:update]

    resources :orders,only: [:index,:show,:update]
  end

  devise_for :admins
end
