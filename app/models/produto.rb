class Produto < ApplicationRecord
  has_many :supermercados,  through: :produtos_precos
  has_many :produtos_precos

  validates :nome_produto, presence: true
  validates :categoria, presence: true
  validates :preco, presence: true
  validates :image_url, presence: true
  validates :disponibilidade, presence: true
end
