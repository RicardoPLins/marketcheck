class AddProdutos < ActiveRecord::Migration[7.1]
  def change
    add_column :produtos, :descricao, :text
    add_column :produtos, :categoria, :string
    add_column :produtos, :marca, :string
    add_column :produtos, :unidade_de_medida, :string
    add_column :produtos, :disponibilidade, :boolean
    add_column :produtos, :avaliacoes, :float
    add_column :produtos, :imagem, :string
    add_column :produtos, :preco, :decimal
    add_column :produtos, :nome_mercado, :string
  end
end
