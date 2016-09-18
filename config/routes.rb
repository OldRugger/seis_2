Seis2::Application.routes.draw do
  # resources :team_members

  # resources :teams

  # resources :day2_awts

  # resources :day1_awts

  resources :teams, only: [:index, :show] do
    collection { post :import}
  end
  
  resources :runners, only: [:index, :show] do
    collection { post :import}
  end
end
