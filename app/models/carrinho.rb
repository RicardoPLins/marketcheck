class Carrinho < ApplicationRecord
  belongs_to :user
  has_many :item_carrinhos  # Assumindo que você tenha uma tabela de itens de carrinho
  has_many :produtos, through: :item_carrinhos  # Relacionamento com produtos através de item_carrinhos
end
