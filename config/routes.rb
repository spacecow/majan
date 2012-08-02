Majan::Application.routes.draw do
  resources :tables, :only => :index
  resources :bookings, :only => :index

  root :to => 'bookings#index'
end
