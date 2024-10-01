require 'bunny'

class CarrinhoConsumer
  def self.start
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    queue = channel.queue('carrinhos')

    puts "Aguardando mensagens na fila 'carrinhos'..."

    begin
      queue.subscribe(block: true) do |delivery_info, _properties, body|
        message = JSON.parse(body)
        puts "Mensagem recebida: #{message}"

        # Lógica para processar o carrinho
        process_carrinho(message)
      end
    rescue Interrupt => _
      channel.close
      connection.close
    end
  end
  MAX_RETRIES = 3

  def self.process_carrinho(message, attempts = 0)
    user_id = message['user_id']
    action = message['action']
    cart_id = message['cart_id']
    item_id = message['item_id']
    quantity = message['quantity']

    begin
      case action
      when 'create'
        create_carrinho(user_id, cart_id)
      when 'update'
        update_carrinho(cart_id, item_id, quantity)
      when 'remove'
        remove_item(cart_id, item_id)
      else
        puts "Ação desconhecida: #{action}"
      end
    rescue => e
      puts "Erro ao processar a mensagem: #{e.message}"
      if attempts < MAX_RETRIES
        puts "Tentando novamente... (Tentativa ##{attempts + 1})"
        process_carrinho(message, attempts + 1)
      else
        puts "Falha ao processar a mensagem após #{MAX_RETRIES} tentativas. Registro do erro."
      end
    end
  end

  private

  def self.create_carrinho(user_id, cart_id)
    # Lógica para criar um carrinho
    puts "Criando carrinho ##{cart_id} para o usuário ##{user_id}"
  end

  def self.update_carrinho(cart_id, item_id, quantity)
    # Lógica para atualizar a quantidade de um item no carrinho
    puts "Atualizando o item ##{item_id} no carrinho ##{cart_id} com a quantidade: #{quantity}"
  end

  def self.remove_item(cart_id, item_id)
    # Lógica para remover um item do carrinho
    puts "Removendo o item ##{item_id} do carrinho ##{cart_id}"
  end
end
