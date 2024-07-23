class CreateProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.text :descricao
      t.string :categoria
      t.string :marca
      t.decimal :preco
      t.string :unidade_de_medida
      t.boolean :disponibilidade
      t.integer :avaliacoes
      t.string :imagem
      t.string :link

      t.timestamps
    end
  end
end
