require 'bunny'
require 'logger'

class Publisher
  def initialize
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel
    @exchange = @channel.direct('produtos_exchange', durable: true)
    @channel.confirm_select # Habilita confirmação de publisher
    @logger = Rails.logger # Usando o logger do Rails
  end

  def publish(message, routing_key = 'produtos')
    @exchange.publish(message, persistent: true, routing_key: routing_key)

    # Confirmação de publicação
    if @channel.wait_for_confirms
      @logger.info "Mensagem publicada com sucesso: #{message}"
    else
      @logger.error "Falha ao publicar a mensagem."
    end
  end

  def close
    @channel.close if @channel
    @connection.close if @connection
  rescue => e
    @logger.error "Erro ao fechar a conexão: #{e.message}"
  end
end

# Exemplo de uso
begin
  publisher = Publisher.new
  publisher.publish('Novo produto adicionado!')
ensure
  publisher.close
end
