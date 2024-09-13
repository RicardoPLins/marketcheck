class ProdutosPreco < ApplicationRecord
  belongs_to :produto
  belongs_to :supermercado
end
