class CreateProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.string :descricao
      t.string :categoria
      t.string :marca
      t.string :unidade_de_medida
      t.boolean :disponibilidade
      t.float :avaliacoes
      t.string :imagem
      t.decimal :preco
      t.string :nome_mercado

      t.timestamps
    end
  end
end
