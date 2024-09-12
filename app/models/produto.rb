class Produto < ApplicationRecord
  has_many :supermercados
  has_many :produtos_precos
end
