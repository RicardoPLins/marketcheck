class CriarProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.decimal :preco

      t.timestamps
    end
  end
end
