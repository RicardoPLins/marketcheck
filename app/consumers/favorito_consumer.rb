class FavoritosConsumer
  def self.start
    connection = Bunny.new
    connection.start
    channel = connection.create_channel
    queue = channel.queue('favoritos_queue1')

    begin
      puts ' [*] Waiting for messages in favoritos_queue. To exit press CTRL+C'
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        puts " [x] Received #{body}"
        # Aqui você pode processar a mensagem recebida
      end
    rescue Interrupt => _
      connection.close
      exit(0)
    end
  end
end
