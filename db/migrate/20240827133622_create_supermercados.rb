class CreateSupermercados < ActiveRecord::Migration[7.1]
  def change
    create_table :supermercados do |t|
      t.string :nome
      t.string :endereco
      t.string :horario_de_funcionamento

      t.timestamps
    end
  end
end
