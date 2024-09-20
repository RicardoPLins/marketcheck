class ItemCarrinho < ApplicationRecord
  belongs_to :produto
  belongs_to :carrinho
end
