class Carrinho < ApplicationRecord
  belongs_to :user
  has_many :item_carrinhos, dependent: :destroy  # Assumindo que você tenha uma tabela de itens de carrinho
  has_many :produtos, through: :item_carrinhos  # Relacionamento com produtos através de item_carrinhos

  after_create :send_carrinho_created_message
  after_update :send_carrinho_updated_message
  after_destroy :send_carrinho_removed_message

  private

  def send_carrinho_created_message
    action = CarrinhoAction.new('create', user.id, id)
    CarrinhoProducer.send_message(action)
  end

  def send_carrinho_updated_message
    # Supondo que você tenha lógica para obter os itens atualizados
    itens.each do |item|
      action = CarrinhoAction.new('update', user.id, id, item.id, item.quantity)
      CarrinhoProducer.send_message(action)
    end
  end

  def send_carrinho_removed_message(item_id)
    action = CarrinhoAction.new('remove', user.id, id, item_id)
    CarrinhoProducer.send_message(action)
  end
end
