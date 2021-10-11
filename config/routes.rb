Rails.application.routes.draw do
  devise_for :customers

  root :to => 'public/homes#top'
  get 'about' => 'public/homes#about'

  # get 'customers/sign_up' => 'public/registrations#new'
  # post 'customers' => 'public/registrations#create'




  namespace :admin do
    get 'sign_in' => 'devise/sessions#new'
    post 'sign_in' => 'devise/sessions#create'
    delete 'sign_out' => 'devise/sessions#destroy'

    get '' => 'homes#top'

    resources :genres,only: [:index,:create,:edit,:update]

    resources :items,only: [:index,:new,:create,:show,:edit,:update]
    resources :customers,only: [:index,:edit,:show,:update]
  end
end
