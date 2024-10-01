class CarrinhosController < ApplicationController
  before_action :authenticate_user!

  def show
    @carrinho = current_user.carrinho || current_user.create_carrinho
    @produtos = @carrinho.produtos
  end

  def index
    @carrinhos = Carrinho.all
    render :index
  end

  def create
    @carrinho = Carrinho.new(user: current_user)
    if @carrinho.save
      redirect_to carrinhos_path, notice: 'Carrinho criado com sucesso.'
    else
      render :new
    end
  end
  
  
  private
  
  def carrinho_params
    params.require(:carrinho).permit(:nome) # ajuste os parâmetros de acordo com os atributos do modelo
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

  def organizar_caminho
    @carrinho = current_user.carrinho || current_user.create_carrinho

    # A junção deve incluir a tabela que tem a relação com o supermercado
    @produtos = @carrinho.produtos
                          .joins(:produtos_precos) # Substitua por 'produtos_precos' se necessário
                          .joins('JOIN supermercados ON produtos_precos.supermercado_id = supermercados.id')
                          .order('supermercados.nome_mercado ASC, produtos.indicacao_no_mercado ASC')

    render :show
  end
end