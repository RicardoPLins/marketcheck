Rails.application.routes.draw do
  devise_for :users
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
    post 'share', on: :collection, as: 'share'
    get 'shared/:token', on: :collection, to: 'favoritos#show_shared', as: 'shared'
  end
  

  # Rota para verificar o status de saúde do aplicativo
  get "up" => "rails/health#show", as: :rails_health_check

  # Define a rota do caminho raiz ("/")
  root to: "home#index"

  #carrinhos de compra
  resources :carrinhos, only: [:show] do
    delete :remover_todos, on: :collection
  end
  post 'produtos/:id/adicionar_ao_carrinho', to: 'produtos#adicionar_ao_carrinho', as: 'adicionar_ao_carrinho'
  delete 'carrinho/remover_produto/:id', to: 'carrinhos#remover_produto', as: 'remover_produto_carrinho'

  post 'favoritos/adicionar_todos_ao_carrinho', to: 'favoritos#adicionar_todos_ao_carrinho', as: 'adicionar_todos_ao_carrinho'

end