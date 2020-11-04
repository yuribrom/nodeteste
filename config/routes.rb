Rails.application.routes.draw do
  resources :contas

  resources :clientes do
    collection do
      get :extrato
    end
  end

  resources :transferencias

  resources :sessao do
    collection do
      post :sessao_externa
      post :login
      get :logout
    end
  end
  root :to => 'sessao#index'
end
