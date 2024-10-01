Rails.application.routes.draw do
  # Rotas do Devise para usuários
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations'  # Adicionando o controlador de registros
  }

  # Rotas para Supermercados e Produtos
  resources :supermercados

  resources :produtos do
    post 'add_favoritos', on: :member, as: 'add_favoritos'
    collection do
      get 'produtos_menor'
    end
  end

  # Rotas para Favoritos
  resources :favoritos, only: [:index] do
    post 'add', on: :member, as: 'add_to_favoritos'
    delete 'remove', on: :member, as: 'remove_from_favoritos'
    post 'share', on: :collection, as: 'share'
    get 'shared/:token', on: :collection, to: 'favoritos#show_shared', as: 'shared'
  end

  # Verificar o status de saúde do aplicativo
  get "up" => "rails/health#show", as: :rails_health_check

  # Rota raiz
  root to: "home#index"  # Verifique se você tem o HomeController ou altere esta rota

  # Carrinhos de compra
  resources :carrinhos, only: [:show] do
    delete :remover_todos, on: :collection
    get 'organizar_caminho', on: :collection
  end
  post 'produtos/:id/adicionar_ao_carrinho', to: 'produtos#adicionar_ao_carrinho', as: 'adicionar_ao_carrinho'
  delete 'carrinho/remover_produto/:id', to: 'carrinhos#remover_produto', as: 'remover_produto_carrinho'

  post 'favoritos/adicionar_todos_ao_carrinho', to: 'favoritos#adicionar_todos_ao_carrinho', as: 'adicionar_todos_ao_carrinho'

end
