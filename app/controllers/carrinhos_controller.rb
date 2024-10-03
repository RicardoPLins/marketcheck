class CarrinhosController < ApplicationController
  before_action :authenticate_user!

  def show
    @carrinho = current_user.carrinho || current_user.create_carrinho
    @produtos = @carrinho.produtos

    respond_to do |format|
      format.html # renderiza a view padrão show.html.erb
      format.json { render json: @produtos } # renderiza os produtos em formato JSON
    end
  end

  def remover_todos
    current_user.carrinho.item_carrinhos.destroy_all
    publish_message("Todos os produtos foram removidos do carrinho do usuário #{current_user.id}.")
    
    redirect_to carrinho_path(current_user.id), notice: 'Todos os produtos foram removidos!'
  end

  def remover_produto
    item = current_user.carrinho.item_carrinhos.find(params[:id])
    item.destroy
    # publish_message("Produto removido do carrinho: #{item.produto.nome_produto} (ID: #{item.id})")

    redirect_to carrinho_path(current_user.id), notice: 'Produto removido do carrinho!'
  end

  def organizar_caminho
    @carrinho = current_user.carrinho || current_user.create_carrinho
    @produtos = @carrinho.produtos
                          .joins(:produtos_precos) # Substitua por 'produtos_precos' se necessário
                          .joins('JOIN supermercados ON produtos_precos.supermercado_id = supermercados.id')
                          .order('supermercados.nome_mercado ASC, produtos.indicacao_no_mercado ASC')

    publish_message("Carrinho do usuário #{current_user.id} organizado.")

    render :show
  end

  private

  def publish_message(message)
    publisher = Publisher.new
    publisher.publish(message)
    publisher.close
  end
end
