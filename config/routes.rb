Seis2::Application.routes.draw do

  resources :teams, only: [:index, :show] do
    collection { post :import}
  end

  resources :runners, only: :index do
    collection { post :import}
  end

  get "awt" => "awt#index"

  get "teams2" => "teams2#index"

  get "awards" => "awards#index"

  root :to => 'home#index'

  match "*path", to: "home#index", via: :all

end
