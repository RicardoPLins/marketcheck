require 'bunny'

class Consumer
  def initialize
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel

    # Fila principal com DLX configurado
    @queue = @channel.queue('produtos', durable: true, arguments: {
      'x-dead-letter-exchange' => 'dlx_exchange'
    })

    # DLX (Dead-letter exchange) e fila
    @dlx_exchange = @channel.direct('dlx_exchange', durable: true)
    @dead_letter_queue = @channel.queue('produtos_dlx', durable: true)
    @dead_letter_queue.bind(@dlx_exchange)

    @queue.subscribe(manual_ack: true, block: true) do |delivery_info, properties, body|
      begin
        puts "Processando mensagem: #{body}"

        # Simulação de falha para retry
        if body == 'Erro'
          raise StandardError, 'Erro de processamento!'
        end

        # Confirma a mensagem processada
        @channel.ack(delivery_info.delivery_tag)
        puts "Mensagem processada com sucesso: #{body}"
      rescue => e
        puts "Falha ao processar mensagem: #{e.message}"

        # Nega e redireciona para DLX
        @channel.reject(delivery_info.delivery_tag, false)
      end
    end
  end

  def close
    @connection.close
  end
end

consumer = Consumer.new
