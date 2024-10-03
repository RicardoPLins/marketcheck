class CarrinhosController < ApplicationController
  before_action :authorize

  def show
    @carrinho = current_user.carrinho || current_user.create_carrinho
    @item_carrinhos = @carrinho.item_carrinhos.includes(:produto)

    # Inclui o ID de item_carrinho e os detalhes do produto na resposta
    render json: {
      carrinho: @carrinho,
      itens: @item_carrinhos.map { |item| 
        {
          id: item.id,                # ID do item_carrinho
          produto_id: item.produto.id, # ID do produto
          image_url: item.produto.image_url, # URL da imagem do produto
          nome_produto: item.produto.nome_produto,     # Nome do produto
          categoria: item.produto.categoria,   # Categoria do produto
          quantidade: item.quantidade,  # Quantidade do produto
          preco: item.produto.preco,     # Preço do produto
          indicacao_no_mercado: item.produto.indicacao_no_mercado # Indicação do produto no mercado
        } 
      }
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
  
    # A consulta SQL deve unir as tabelas corretas
    @produtos = ActiveRecord::Base.connection.execute <<-SQL
      WITH produtos_ordenados AS (
        SELECT 
          p.*, 
          (REGEXP_MATCHES(p.indicacao_no_mercado, '([0-9]+)'))[1]::INTEGER AS fileira_numero
        FROM produtos p
        JOIN item_carrinhos ic ON p.id = ic.produto_id
        WHERE ic.carrinho_id = #{@carrinho.id}
      )
      SELECT 
        po.*
      FROM produtos_ordenados po
      JOIN produtos_precos pp ON po.id = pp.produto_id
      JOIN supermercados s ON pp.supermercado_id = s.id
      ORDER BY s.nome_mercado ASC, fileira_numero ASC;
    SQL
    publish_message("Carrinho do usuário #{current_user.id} organizado.")
      
    render json: {
      carrinho: @carrinho,
      itens: @produtos.as_json(include: {
        produtos_precos: {
          include: :supermercado
        }
      })
    }, status: :ok
    
  end
  private
  def publish_message(message)
    publisher = Publisher.new
    publisher.publish(message)
    publisher.close
  end
  
end
