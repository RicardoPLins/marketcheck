class AddLocalizacaoToProdutos < ActiveRecord::Migration[7.1]
  def change
    add_column :produtos, :localizacao, :string
  end
end
