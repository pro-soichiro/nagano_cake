Rails.application.routes.draw do
  devise_for :customers

  root :to => 'public/homes#top'
  get 'about' => 'public/homes#about'

  get 'customers/my_page' => 'public/customers#show'
  get 'customers/edit' => 'public/customers#edit'
  patch 'customers' => 'public/customers#update'


  # resource :customers,only: [:update]


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
