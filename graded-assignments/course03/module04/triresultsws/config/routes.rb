Rails.application.routes.draw do
  resources :racers do
    post "entries" => "racers#create_entry"
  end
  
  resources :races

  namespace :api do
    resources :races, only: [:index, :show, :create, :update, :destroy] do
      resources :results, only: [:index, :show, :update]
    end
    resources :racers, only: [:index, :show] do
      resources :entries, only: [:index, :show]
    end
  end
end
