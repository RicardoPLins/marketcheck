class FavoritosController < ApplicationController
  before_action :authorize

  # Adiciona um produto à lista de favoritos do usuário
  def add
    product_id = params[:id].to_i
    produto = Produto.find(product_id)

    if current_user.produtos_favoritos.exists?(produto.id)
      render json: { status: 'error', message: 'Produto já está na lista de favoritos' }, status: :unprocessable_entity
    else
      current_user.produtos_favoritos << produto

      # Publicar mensagem no RabbitMQ
      RabbitmqService.publish('favoritos_queue', "Usuário #{current_user.id} adicionou o produto #{produto.id} aos favoritos.")

      render json: { status: 'success', message: 'Produto adicionado aos favoritos' }, status: :ok
    end
  end

  # Lista os produtos favoritos do usuário
  def index
    @favoritos = current_user.produtos_favoritos

    respond_to do |format|
      format.json { render json: @favoritos }
      format.html
    end
  end

  # Remove um produto da lista de favoritos
  def remove
    product_id = params[:id].to_i
    produto = current_user.produtos_favoritos.find_by(id: product_id)

    if produto
      # Remove o produto dos favoritos do usuário
      current_user.produtos_favoritos.delete(produto)

      # Publicar mensagem no RabbitMQ
      RabbitmqService.publish('favoritos_queue', "Usuário #{current_user.id} removeu o produto #{produto.id} dos favoritos.")

      render json: { status: 'success', message: 'Produto removido dos favoritos' }, status: :ok
    else
      render json: { status: 'error', message: 'Produto não encontrado na lista de favoritos' }, status: :unprocessable_entity
    end
  end

  # Compartilha a lista de favoritos do usuário
  def share
    favoritos = current_user.produtos_favoritos

    if favoritos.present?
      token = SecureRandom.hex(10)
      Rails.cache.write("favoritos_#{token}", favoritos.pluck(:id), expires_in: 1.hour)

      redirect_to shared_favoritos_path(token: token), notice: "Lista de favoritos compartilhada com sucesso!"
    else
      redirect_to favoritos_path, alert: "Lista de favoritos está vazia."
    end
  end

  # Mostra a lista de favoritos compartilhados
  def show_shared
    @token = params[:token]
    favoritos_ids = Rails.cache.read("favoritos_#{@token}") || []
    @favoritos = Produto.where(id: favoritos_ids)

    if @favoritos.empty?
      redirect_to favoritos_path, alert: "Lista de favoritos não encontrada ou está vazia."
    end
  end  

  # Adiciona todos os favoritos ao carrinho do usuário
  def adicionar_todos_ao_carrinho
    carrinho = current_user.carrinho || current_user.create_carrinho

      favoritos = current_user.produtos_favoritos
      if favoritos.empty?
        redirect_to favoritos_path, alert: 'Sua lista de favoritos está vazia!'
        return
      end

      favoritos.each do |produto|
        item = carrinho.item_carrinhos.find_or_initialize_by(produto: produto)
        
        # Inicializa a quantidade se for nil
        item.quantidade ||= 0  # Se for nil, define como 0
        item.quantidade += 1   # Agora pode incrementar
        item.save
      end

      # Publicar mensagem no RabbitMQ após adicionar todos os favoritos ao carrinho
      RabbitmqService.publish('favoritos_queue', "Usuário #{current_user.id} adicionou todos os produtos favoritos ao carrinho.")

      render json: { status: 'success', message: 'Favoritos adicionados ao carrinho' }, status: :ok
  end
end
