class CarrinhosController < ApplicationController
  before_action :authenticate_user!

  # Método para exibir o carrinho do usuário
  def show
    @carrinho = current_user.carrinho || current_user.create_carrinho
    @produtos = @carrinho.produtos

    # Retorna os produtos do carrinho em formato JSON
    render json: @produtos, status: :ok
  end

  # Método para remover todos os produtos do carrinho
  def remover_todos
    current_user.carrinho.item_carrinhos.destroy_all

    # Retorna uma resposta JSON ao invés de redirecionar
    render json: { message: 'Todos os produtos foram removidos!' }, status: :ok
  end

  # Método para remover um produto específico do carrinho
  def remover_produto
    item = current_user.carrinho.item_carrinhos.find(params[:id])
    item.destroy

    # Retorna uma resposta JSON ao invés de redirecionar
    render json: { message: 'Produto removido do carrinho!' }, status: :ok
  end

  # Método para organizar produtos do carrinho
  def organizar_caminho
    @carrinho = current_user.carrinho || current_user.create_carrinho
    @produtos = @carrinho.produtos
                          .joins(:produtos_precos)
                          .joins('JOIN supermercados ON produtos_precos.supermercado_id = supermercados.id')
                          .order('supermercados.nome_mercado ASC, produtos.indicacao_no_mercado ASC')

    # Retorna os produtos organizados em formato JSON
    render json: @produtos, status: :ok
  end
end
