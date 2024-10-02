class CreateProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :produtos do |t|
      t.string :nome_produto, null: false
      t.string :link_to_item
      t.string :image_url
      t.decimal :preco, precision: 10, scale: 2, null: false
      t.string :categoria

      t.timestamps
    end
  end
end
