Seis2::Application.routes.draw do

  resources :teams, only: [:index, :show] do
    collection { post :import}
  end
  
  resources :runners, only: [:index, :show] do
    collection { post :import}
  end
end
