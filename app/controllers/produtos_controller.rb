class ProdutosController < ApplicationController
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
    @outros_produtos = Produto.where(nome: @produto.nome).where.not(id: @produto.id)
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit; end

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



  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def produto_params
    params.require(:produto).permit(:nome, :descricao, :categoria, :marca, :preco, :unidade_de_medida, :disponibilidade, :avaliacoes, :imagem, :nome_mercado, :supermercado_id, :localizacao)
  end  
end
