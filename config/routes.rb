Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers

  get 'about' => 'public/homes#about'
  
  namespace :admin do
    get 'sign_in' => 'sessions#new'
    post 'sign_in' => 'sessions#create'
    
    
  end



end
