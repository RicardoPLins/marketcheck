class Supermercado < ApplicationRecord
  has_many :produtos
  has_many :produtos_precos
end
