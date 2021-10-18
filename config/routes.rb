Rails.application.routes.draw do

  root :to => 'public/homes#top'
  get 'about' => 'public/homes#about'

  get 'customers/my_page' => 'public/customers#show'
  get 'customers/edit' => 'public/customers#edit'
  patch 'customers' => 'public/customers#update'
  get 'customers/unsubscribe' => 'public/customers#unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw'

  get 'addresses' => 'public/addresses#index'
  post 'addresses' => 'public/addresses#create'
  get 'addresses/:id/edit' => 'public/addresses#edit',as: 'address_edit'
  patch 'addresses/:id' => 'public/addresses#update',as: 'address'
  delete 'addresses/:id' => 'public/addresses#destroy'
  # resources :addresses,only: [:edit,:update,:destroy]

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
