class ProdutosController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_produto, only: %i[show edit update destroy]

  def index
    @produtos = Produto.all
    if params[:search].present?
      @produtos = @produtos.where('nome LIKE ?', "%#{params[:search]}%")
    end

    if params[:order] == 'preco_crescente'
      @produtos = @produtos.order(preco: :asc)
    end
  end

  def show
    @outros_produtos = Produto.where(nome: @produto.nome_produto).where.not(id: @produto.id)
  end

  def new
    authorize! :create, @produto
    @produto = Produto.new
  end

  def edit
    authorize! :create, @produto
    @produto = Produto.find(params[:id])
  end

  def create
    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        publish_message("Produto criado: #{@produto.nome_produto}")

        format.html { redirect_to produto_url(@produto), notice: "Produto foi criado com sucesso." }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @produto.update(produto_params)
        publish_message("Produto atualizado: #{@produto.nome_produto}")

        format.html { redirect_to produto_url(@produto), notice: "Produto foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    produto_nome = @produto.nome_produto
    @produto.destroy!

    publish_message("Produto destruído: #{produto_nome}")

    respond_to do |format|
      format.html { redirect_to produtos_url, notice: "Produto foi destruído com sucesso." }
      format.json { head :no_content }
    end
  end

  def produtos_menor
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

    authorize! :add_to_carrinho, @produto

    if user_signed_in?
      Rails.logger.debug "Usuário atual: #{current_user.id}"
      carrinho = current_user.carrinho || current_user.create_carrinho
      Rails.logger.debug "Carrinho ID: #{carrinho.id}"

      item = carrinho.item_carrinhos.find_or_initialize_by(produto: @produto)
      item.quantidade ||= 0  # Se for nil, define como 0
      item.quantidade += 1   # Agora pode incrementar
      item.save

      publish_message("Produto adicionado ao carrinho: #{@produto.nome_produto}")

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
    params.require(:produto).permit(:nome_produto, :categoria, :preco, :image_url, :nome_mercado, :localizacao)
  end

  def publish_message(message)
    publisher = Publisher.new
    publisher.publish(message)
    publisher.close
  end
end
