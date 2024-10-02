Rails.application.routes.draw do
  # Rotas do Devise, utilizando um controlador customizado para as registrations
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Rotas do dashboard para o admin e o usuário comum
  get 'admin_dashboard', to: 'admin#dashboard'  # Rota para o dashboard do admin
  get 'user_dashboard', to: 'users#dashboard'   # Rota para o dashboard do usuário

  # Rotas para os supermercados (CRUD)
  resources :supermercados

  # Rotas para produtos, com funcionalidades extras
  resources :produtos do
    # Rota para adicionar o produto aos favoritos
    post 'add_favoritos', on: :member, as: 'add_favoritos'
    
    # Rota para buscar o produto com o menor preço
    collection do
      get 'produtos_menor'
    end
  end

  # Rotas para os favoritos
  resources :favoritos, only: [:index] do
    # Rota para adicionar e remover produtos dos favoritos
    post 'add', on: :member, as: 'add_to_favoritos'
    delete 'remove', on: :member, as: 'remove_from_favoritos'

    # Rota para compartilhar a lista de favoritos
    post 'share', on: :collection, as: 'share'

    # Rota para acessar uma lista de favoritos compartilhada via token
    get 'shared/:token', on: :collection, to: 'favoritos#show_shared', as: 'shared'
  end

  # Rota para verificar o status de saúde do aplicativo
  get "up" => "rails/health#show", as: :rails_health_check

  # Define a rota do caminho raiz ("/")
  root to: "home#index"

  # Rotas para o carrinho de compras
  resources :carrinhos, only: [:show] do
    # Rota para remover todos os produtos do carrinho
    delete :remover_todos, on: :collection
    
    # Rota para organizar o caminho no supermercado
    get 'organizar_caminho', on: :collection
  end

  # Rota para adicionar um produto ao carrinho
  post 'produtos/:id/adicionar_ao_carrinho', to: 'produtos#adicionar_ao_carrinho', as: 'adicionar_ao_carrinho'

  # Rota para remover um produto específico do carrinho
  delete 'carrinho/remover_produto/:id', to: 'carrinhos#remover_produto', as: 'remover_produto_carrinho'

  # Rota para adicionar todos os favoritos ao carrinho
  post 'favoritos/adicionar_todos_ao_carrinho', to: 'favoritos#adicionar_todos_ao_carrinho', as: 'adicionar_todos_ao_carrinho'
end
