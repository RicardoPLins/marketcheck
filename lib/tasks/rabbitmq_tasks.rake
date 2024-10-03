# lib/tasks/rabbitmq_tasks.rake
namespace :rabbitmq do
  desc 'Inicia os consumidores'
  task start_consumers: :environment do
    Thread.new { Consumer.new }
    Thread.new { ConsumerWithRetry.new }
    puts 'Consumidores iniciados...'
  end
end
