class ConsumerWithRetry
  def initialize
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel

    # Fila principal com DLX e TTL configurados
    @queue = @channel.queue('produtos', durable: true, arguments: {
      'x-dead-letter-exchange' => 'retry_exchange',
      'x-message-ttl' => 10000 # 10 segundos de espera antes de retry
    })

    # Exchange para retry
    @retry_exchange = @channel.direct('retry_exchange', durable: true)
    @retry_queue = @channel.queue('produtos_retry', durable: true, arguments: {
      'x-dead-letter-exchange' => 'produtos_exchange' # Volta para a fila original após retry
    })

    @retry_queue.bind(@retry_exchange)

    @queue.subscribe(manual_ack: true, block: true) do |delivery_info, properties, body|
      begin
        puts "Processando mensagem: #{body}"

        # Simulação de falha para retry
        if body == 'Erro'
          raise StandardError, 'Erro de processamento!'
        end

        @channel.ack(delivery_info.delivery_tag)
        puts "Mensagem processada com sucesso: #{body}"
      rescue => e
        puts "Falha ao processar, mandando para retry: #{e.message}"
        @channel.reject(delivery_info.delivery_tag, false)
      end
    end
  end

  def close
    @connection.close
  end
end

consumer_with_retry = ConsumerWithRetry.new
