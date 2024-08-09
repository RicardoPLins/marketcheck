class RenameNameToNomeInProdutos < ActiveRecord::Migration[7.1]
  def change
    rename_column :produtos, :name, :nome
  end
end
