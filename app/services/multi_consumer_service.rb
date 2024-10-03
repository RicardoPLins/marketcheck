require 'bunny'

class MultiConsumerService
  def initialize(num_consumers = 3)
    @num_consumers = num_consumers
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel
    @queue = @channel.queue('produtos', durable: true)
  end

  def start_consumers
    threads = []

    @num_consumers.times do |i|
      threads << Thread.new do
        puts "Iniciando consumidor #{i + 1}..."
        @queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
          process_message(body)
          @channel.ack(delivery_info.delivery_tag)
        end
      end
    end

    threads.each(&:join) # Garante que as threads rodem em paralelo
  end

  def process_message(message)
    puts "Processando mensagem: #{message}"
    # Aqui você pode adicionar lógica de negócio para processar cada mensagem
    sleep(2) # Simula processamento pesado ou longo
    puts "Mensagem processada: #{message}"
  end

  def close_connection
    @connection.close
  end
end

# Exemplo de uso
multi_consumer = MultiConsumerService.new(5) # Inicializa com 5 consumidores
multi_consumer.start_consumers
