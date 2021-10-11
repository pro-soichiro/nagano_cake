Rails.application.routes.draw do
  devise_for :customers

  get 'about' => 'public/homes#about'

  namespace :admin do
    get 'sign_in' => 'devise/sessions#new'
    post 'sign_in' => 'devise/sessions#create'
    delete 'sign_out' => 'devise/sessions#destroy'

    get '' => 'homes#top'

    resources :genres,only: [:index,:create,:edit,:update]

    resources :items,only: [:index,:new,:create,:show,:edit,:update]
  end



end
