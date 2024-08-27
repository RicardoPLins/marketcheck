# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_27_133756) do
  create_table "produtos", force: :cascade do |t|
    t.string "nome"
    t.string "descricao"
    t.string "categoria"
    t.string "marca"
    t.decimal "preco"
    t.string "unidade_de_medida"
    t.boolean "disponibilidade"
    t.float "avaliacoes"
    t.string "imagem"
    t.string "nome_mercado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "supermercado_id", null: false
    t.index ["supermercado_id"], name: "index_produtos_on_supermercado_id"
  end

  create_table "supermercados", force: :cascade do |t|
    t.string "nome"
    t.string "endereco"
    t.string "horario_de_funcionamento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "produtos", "supermercados"
end
