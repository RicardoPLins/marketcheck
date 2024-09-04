class FavoritosController < ApplicationController
  # Adiciona um produto à lista de favoritos
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
    else
      flash[:alert] = 'Produto já está na lista de favoritos.'
    end

    # Transmitir a mensagem para o canal usando ActionCable
    ActionCable.server.broadcast('favoritos_channel', { message: "A lista de favoritos foi atualizada. Um produto foi adicionado" })

    # Publicar mensagem no RabbitMQ
    RabbitMQService.publish('favoritos_queue', 'Um novo produto foi adicionado na lista de favoritos.')

    redirect_to favoritos_path
  end

  # Lista os produtos favoritos
  def index
    # Obtém a lista de IDs dos produtos favoritos do cache
    @favoritos_ids = Rails.cache.fetch('favoritos') { [] }
    @favoritos = Produto.where(id: @favoritos_ids)

    # Quando o front tiver pronto
    # render json: @favoritos
  end

  # Remove um produto da lista de favoritos
  def remove
    # Obtém a lista de favoritos do cache ou inicializa como um array vazio
    favoritos = Rails.cache.read('favoritos') || []

    # Converte o ID do produto para inteiro
    product_id = params[:id].to_i

    # Remove o ID do produto da lista de favoritos, se estiver presente
    if favoritos.delete(product_id)
      Rails.cache.write('favoritos', favoritos) # Atualiza o cache
      flash[:notice] = 'Produto removido dos favoritos com sucesso.'
    else
      flash[:alert] = 'Produto não encontrado na lista de favoritos.'
    end
    # Transmitir a mensagem para o canal usando ActionCable
    ActionCable.server.broadcast('favoritos_channel', { message: "A lista de favoritos foi atualizada. Um produto foi removido" })

    
    # Publicar mensagem no RabbitMQ
    RabbitMQService.publish('favoritos_queue', 'Um produto foi removido da lista de favoritos.')

    redirect_to favoritos_path
  end

  # Compartilha a lista de favoritos
  def share
    favoritos = Rails.cache.read('favoritos') || []
    if favoritos.present?
      token = SecureRandom.hex(10)
      Rails.cache.write("favoritos_#{token}", favoritos, expires_in: 24.hours)

      # Redirecionar para a view que mostrará o link compartilhado
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
  private

  def send_notification(message)
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    queue = channel.queue('favorites_notifications')

    channel.default_exchange.publish(message, routing_key: queue.name)
    connection.close
  end

end
