class AddSupermercadoToProdutos < ActiveRecord::Migration[7.1]
  def change
    add_reference :produtos, :supermercado, null: false, foreign_key: true
  end
end
