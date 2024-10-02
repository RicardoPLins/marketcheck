class Produto < ApplicationRecord
  has_many :supermercados,  through: :produtos_precos
  has_many :produtos_precos
end
