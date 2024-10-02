class CreateItemCarrinhos < ActiveRecord::Migration[7.1]
  def change
    create_table :item_carrinhos do |t|
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade
      t.references :carrinho, null: false, foreign_key: true

      t.timestamps
    end
  end
end
