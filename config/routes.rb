Rails.application.routes.draw do


  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'

    resources :items,only: [:index,:show]

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

    devise_for :customers
  end


  namespace :admin do

    get '' => 'homes#top'

    resources :items,only: [:index,:new,:create,:show,:edit,:update]

    resources :genres,only: [:index,:create,:edit,:update]

    resources :customers,only: [:index,:edit,:show,:update]

    resources :orders,only: [:index,:show,:update]
  end

  devise_for :admin , module: 'admin'

  # devise_scope :admin do
  #   get "sign_in" => "admin/sessions#new"
  #   get "sign_out" => "admin/sessions#destroy"
  # end

end
