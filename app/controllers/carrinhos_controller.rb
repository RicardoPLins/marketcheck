class CarrinhosController < ApplicationController
  before_action :authorize

  def show
    @carrinho = current_user.carrinho || current_user.create_carrinho
    @produtos = @carrinho.produtos

    # Retornando JSON com os detalhes do carrinho e produtos
    render json: {
      carrinho: @carrinho,
      produtos: @produtos
    }, status: :ok
  end

  def remover_todos
    current_user.carrinho.item_carrinhos.destroy_all
    publish_message("Todos os produtos foram removidos do carrinho do usuário #{current_user.id}.")
    # Retornando JSON de sucesso
    render json: { message: 'Todos os produtos foram removidos!' }, status: :ok
  end

  def remover_produto
    item = current_user.carrinho.item_carrinhos.find(params[:id])
    item.destroy
    publish_message("Produto removido do carrinho: #{item.produto.nome_produto} (ID: #{item.id})")
    # Retornando JSON de sucesso
    render json: { message: 'Produto removido do carrinho!' }, status: :ok
  end

  def organizar_caminho
    @carrinho = current_user.carrinho || current_user.create_carrinho

    # A junção deve incluir a tabela que tem a relação com o supermercado
    @produtos = @carrinho.produtos
                          .joins(:produtos_precos) # Substitua por 'produtos_precos' se necessário
                          .joins('JOIN supermercados ON produtos_precos.supermercado_id = supermercados.id')
                          .order('supermercados.nome_mercado ASC, produtos.indicacao_no_mercado ASC')

    

    publish_message("Carrinho do usuário #{current_user.id} organizado.")
  end

  private

  def publish_message(message)
    publisher = Publisher.new
    publisher.publish(message)
    publisher.close
  # Retornando JSON com os produtos organizados
  render json: {
      carrinho: @carrinho,
      produtos: @produtos
    }, status: :ok
    
  end
end
