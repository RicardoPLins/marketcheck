Rails.application.routes.draw do
  resources :supermercados
  
  resources :produtos do
    post 'add_favoritos', on: :member, as: 'add_favoritos' # Rota para adicionar aos favoritos
    collection do
      get 'produtos_menor' # Rota para buscar o produto mais barato
    end
  end

  resources :favoritos, only: [:index] do
    post 'add', on: :member, as: 'add_to_favoritos' # Rota para adicionar à lista de favoritos
    delete 'remove', on: :member, as: 'remove_from_favoritos' # Rota para remover da lista de favoritos
  end

  # Rota para verificar o status de saúde do aplicativo
  get "up" => "rails/health#show", as: :rails_health_check

  # Define a rota do caminho raiz ("/")
  # root "posts#index"
end
