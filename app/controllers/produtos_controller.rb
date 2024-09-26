class ProdutosController < ApplicationController
  # load_and_authorize_resource
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_produto, only: %i[show edit update destroy]

  # GET /produtos or /produtos.json
  def index
    @produtos = Produto.all
    if params[:search].present?
      @produtos = @produtos.where('nome LIKE ?', "%#{params[:search]}%")
    end

    if params[:order] == 'preco_crescente'
      @produtos = @produtos.order(preco: :asc)
    end
  end

  # GET /produtos/1 or /produtos/1.json
  def show
    @outros_produtos = Produto.where(nome: @produto.nome_produto).where.not(id: @produto.id)
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
    @produto = Produto.find(params[:id])
  end

  # POST /produtos or /produtos.json
  def create
    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        format.html { redirect_to produto_url(@produto), notice: "Produto was successfully created." }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1 or /produtos/1.json
  def update
    respond_to do |format|
      if @produto.update(produto_params)
        format.html { redirect_to produto_url(@produto), notice: "Produto was successfully updated." }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1 or /produtos/1.json
  def destroy
    @produto.destroy!

    respond_to do |format|
      format.html { redirect_to produtos_url, notice: "Produto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /produtos/produtos_menor
def produtos_menor
  # Obtenha os produtos com o menor preço por nome usando uma subconsulta
  subquery = Produto.select('nome, MIN(preco) AS min_preco')
                    .group('nome')
          

  @produtos_menor = Produto.joins("INNER JOIN (#{subquery.to_sql}) AS sub ON produtos.nome = sub.nome AND produtos.preco = sub.min_preco")


  respond_to do |format|
    format.html
    format.json { render json: @produtos_menor }
  end
end
  def adicionar_ao_carrinho
    @produto = Produto.find(params[:id])

    if user_signed_in?
      # Obtenha o carrinho do usuário ou crie um novo se não existir
      Rails.logger.debug "Usuário atual: #{current_user.id}"
      carrinho = current_user.carrinho || current_user.create_carrinho
      Rails.logger.debug "Carrinho ID: #{carrinho.id}"
  

      # Encontre ou inicialize o item no carrinho
      item = carrinho.item_carrinhos.find_or_initialize_by(produto: @produto)
      
      # Inicialize a quantidade se for nil
      item.quantidade ||= 0  # Se for nil, define como 0
      item.quantidade += 1   # Agora pode incrementar
      item.save

      redirect_to carrinho_path, notice: 'Produto adicionado ao carrinho!'
    else
      redirect_to new_user_session_path, alert: 'Você precisa estar logado para adicionar produtos ao carrinho.'
    end
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def produto_params
    params.require(:produto).permit(:nome_produto, :categoria,  :preco, :image_url, :nome_mercado, :localizacao)
  end  
end
