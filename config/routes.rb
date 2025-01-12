Rails.application.routes.draw do
  get "health", to: "health#check"

  resources :users do
    resources :accounts do
      resources :transactions, only: [ :create, :show ]
    end
  end
end
