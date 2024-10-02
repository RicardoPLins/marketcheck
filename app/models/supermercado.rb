class Supermercado < ApplicationRecord
  has_many :produtos,  through: :produtos_precos
  has_many :produtos_precos
end
