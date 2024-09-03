class FavoritosController < ApplicationController
  def add
    # Obtém a lista de favoritos do cache ou inicializa como um array vazio
    favoritos = Rails.cache.fetch('favoritos') { [] }
  
    # Converte o ID do produto para inteiro
    product_id = params[:id].to_i
  
    # Adiciona o ID do produto aos favoritos, se ainda não estiver na lista
    unless favoritos.include?(product_id)
      favoritos << product_id
      Rails.cache.write('favoritos', favoritos, expires_in: 8.hours) # Define a expiração ao gravar no cache
    end

    # Redireciona para a lista de favoritos com uma mensagem de sucesso
    redirect_to favoritos_path, notice: 'Produto adicionado aos favoritos com sucesso.'
  end

  def index
    # Obtém a lista de IDs dos produtos favoritos do cache
    favoritos = Rails.cache.fetch('favoritos') { [] }

    # Carrega os produtos correspondentes
    @favoritos = Produto.where(id: favoritos)

    # Quando o front tiver pronto
    # render json: @favoritos
  end


  def remove
    # Obtém a lista de favoritos do cache ou inicializa como um array vazio
    favoritos = Rails.cache.read('favoritos') || []
  
    # Converte o ID do produto para inteiro (ou string, dependendo do que você está usando)
    product_id = params[:id].to_i
  
    # Remove o ID do produto da lista de favoritos, se estiver presente
    favoritos.delete(product_id)
  
    # Atualiza o cache com a nova lista de favoritos
    Rails.cache.write('favoritos', favoritos, expires_in: 8.hours)
  
    redirect_to favoritos_path
  end
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
  
  def show_shared
    @token = params[:token]
    @favoritos = Rails.cache.read("favoritos_#{@token}") || []
  
    if @favoritos.empty?
      redirect_to favoritos_path, alert: "Lista de favoritos não encontrada ou está vazia."
    end
  end  
end
