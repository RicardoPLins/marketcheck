class CreateSupermercados < ActiveRecord::Migration[7.1]
  def change
    create_table :supermercados do |t|
      t.string :nome_mercado, null: false
      t.string :website
      t.string :localizacao
      t.string :horario_funcionamento

      t.timestamps
    end
  end
end
