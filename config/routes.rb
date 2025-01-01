Rails.application.routes.draw do
  get "health", to: "health#check"

  resource :users do
    resource :accounts do
      resource :transactions, only: [ :create, :show ]
    end
  end
end
