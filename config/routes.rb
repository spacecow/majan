Majan::Application.routes.draw do
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  resources :sessions, :only => [:new,:create,:destroy]
  resources :users, :only => :show

  resources :days, :only => [:create,:destroy]
  resources :tables, :only => :index
  resources :bookings, :only => [:index, :new, :create] do
    collection do
      get :detail
    end
  end

  get 'welcome' => 'bookings#index'
  root :to => 'bookings#index'
end
