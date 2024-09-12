class FavoritosController < ApplicationController
  # Adiciona um produto à lista de favoritos
  skip_before_action :verify_authenticity_token, only: [:add , :remove]

  def add
    # Obtém a lista de favoritos do cache ou inicializa como um array vazio
    favoritos = Rails.cache.fetch('favoritos') { [] }

    # Converte o ID do produto para inteiro
    product_id = params[:id].to_i

    # Adiciona o ID do produto aos favoritos, se ainda não estiver na lista
    unless favoritos.include?(product_id)
      favoritos << product_id
      Rails.cache.write('favoritos', favoritos) # O tempo de expiração já está definido na configuração do cache
      flash[:notice] = 'Produto adicionado aos favoritos com sucesso.'
      
      # Transmitir a mensagem para o canal usando ActionCable
      ActionCable.server.broadcast('favoritos_channel', { message: "A lista de favoritos foi atualizada. Um produto foi adicionado" })

      # Publicar mensagem no RabbitMQ
      RabbitmqService.publish('favoritos_queue', 'Um novo produto foi adicionado na lista de favoritos.')
      
      # Renderiza a resposta JSON se necessário
      render json: { status: 'success', message: 'Produto adicionado aos favoritos' }, status: :ok
    else
      flash[:alert] = 'Produto já está na lista de favoritos.'
      render json: { status: 'error', message: 'Produto já está na lista de favoritos' }, status: :unprocessable_entity
    end
  end

  # Lista os produtos favoritos
  # Lista os produtos favoritos
  def index
    @favoritos_ids = Rails.cache.fetch('favoritos') { [] }
    @favoritos = Produto.where(id: @favoritos_ids)

    respond_to do |format|
      format.json { render json: @favoritos }  # Retorna a lista de favoritos como JSON
      format.html # Renderiza a visualização HTML caso seja necessário
    end
  end

  # Remove um produto da lista de favoritos
  def remove
    favoritos = Rails.cache.read('favoritos') || []
    product_id = params[:id].to_i

    if favoritos.delete(product_id)
      Rails.cache.write('favoritos', favoritos)
      flash[:notice] = 'Produto removido dos favoritos com sucesso.'
      
      # Transmitir a mensagem para o canal usando ActionCable
      ActionCable.server.broadcast('favoritos_channel', { message: "A lista de favoritos foi atualizada. Um produto foi removido" })

      # Publicar mensagem no RabbitMQ
      RabbitmqService.publish('favoritos_queue', 'Um produto foi removido da lista de favoritos.')

      render json: { status: 'success', message: 'Produto removido dos favoritos' }, status: :ok
    else
      flash[:alert] = 'Produto não encontrado na lista de favoritos.'
      render json: { status: 'error', message: 'Produto não encontrado na lista de favoritos' }, status: :unprocessable_entity
    end
  end

  # Compartilha a lista de favoritos
  def share
    favoritos = Rails.cache.read('favoritos') || []
    if favoritos.present?
      token = SecureRandom.hex(10)
      Rails.cache.write("favoritos_#{token}", favoritos, expires_in: 24.hours)

      redirect_to shared_favoritos_path(token: token), notice: "Lista de favoritos compartilhada com sucesso!"
    else
      redirect_to favoritos_path, alert: "Lista de favoritos está vazia."
    end
  end

  # Mostra a lista de favoritos compartilhados
  def show_shared
    @token = params[:token]
    @favoritos = Rails.cache.read("favoritos_#{@token}") || []

    if @favoritos.empty?
      redirect_to favoritos_path, alert: "Lista de favoritos não encontrada ou está vazia."
    end
  end  
end
