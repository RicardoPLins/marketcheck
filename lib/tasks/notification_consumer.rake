namespace :notifications do
  desc "Start the notification consumer"
  task start: :environment do
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    queue = channel.queue('favorites_notifications')

    puts "Listening for notifications..."

    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      puts "Received notification: #{body}"
      # Here, you can trigger ActionCable or any other notification system
    end

    connection.close
  end
end
