class CreateProdutosPrecos < ActiveRecord::Migration[7.1]
  def change
    create_table :produtos_precos do |t|
      t.references :produto, null: false, foreign_key: true
      t.references :supermercado, null: false, foreign_key: true
      t.decimal :preco
      t.timestamp :date_scraped, default: -> { 'CURRENT_TIMESTAMP' }
      t.boolean :promocao, default: false

      t.timestamps
    end
  end
end