# lib/tasks/multi_consumers.rake
namespace :rabbitmq do
  desc 'Inicia múltiplos consumidores'
  task start_multi_consumers: :environment do
    multi_consumer = MultiConsumerService.new(5) # Inicia com 5 consumidores
    multi_consumer.start_consumers
  end
end
