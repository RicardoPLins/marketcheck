class RabbitmqService
  def self.publish(queue_name, message)
    connection = Bunny.new
    connection.start
    channel = connection.create_channel
    queue = channel.queue(queue_name)
    queue.publish(message)
    connection.close
  end
end
