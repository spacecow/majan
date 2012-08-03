Majan::Application.routes.draw do
  resources :days, :only => :show
  resources :tables, :only => :index
  resources :bookings, :only => [:index, :new, :create] do
    collection do
      get :detail
    end
  end

  root :to => 'bookings#index'
end
