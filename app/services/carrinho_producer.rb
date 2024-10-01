require 'bunny'

class CarrinhoProducer
  def self.send_message(carrinho_action)
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    queue = channel.queue('carrinhos')

    message = carrinho_action.to_json
    queue.publish(message)

    puts "Mensagem enviada: #{message}"

    connection.close
  end
end
