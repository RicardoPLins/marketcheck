Rails.application.routes.draw do
  resources :produtos do
    collection do
      get 'produtos_menor' # Rota para o novo endpoint
    end
  end

  # Define sua aplicação de acordo com o DSL em https://guides.rubyonrails.org/routing.html

  # Revela status de saúde em /up que retorna 200 se o aplicativo inicializa sem exceções, caso contrário 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Define a rota do caminho raiz ("/")
  # root "posts#index"
end
