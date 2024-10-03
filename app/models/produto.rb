class Produto < ApplicationRecord
  has_many :supermercados,  through: :produtos_precos
  has_many :produtos_precos
  has_many :favoritos
  has_many :users_favoritaram, through: :favoritos, source: :user
end
