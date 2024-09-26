class CarrinhosController < ApplicationController
  before_action :authenticate_user!

  def show
    @carrinho = current_user.carrinho || current_user.create_carrinho
    @produtos = @carrinho.produtos
  end
  

  def remover_todos
    current_user.carrinho.item_carrinhos.destroy_all
    redirect_to carrinho_path(current_user.id), notice: 'Todos os produtos foram removidos!'
  end

  def remover_produto
    item = current_user.carrinho.item_carrinhos.find(params[:id])
    item.destroy
    redirect_to carrinho_path(current_user.id), notice: 'Produto removido do carrinho!'
  end
end
