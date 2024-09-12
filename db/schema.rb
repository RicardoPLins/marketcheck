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

ActiveRecord::Schema[7.1].define(version: 2024_09_12_141450) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "produtos", force: :cascade do |t|
    t.string "nome_produto", null: false
    t.string "link_to_item"
    t.string "image_url"
    t.decimal "preco", precision: 10, scale: 2, null: false
    t.string "categoria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produtos_precos", force: :cascade do |t|
    t.bigint "produto_id", null: false
    t.bigint "supermercado_id", null: false
    t.decimal "preco"
    t.datetime "date_scraped", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "promocao", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["produto_id"], name: "index_produtos_precos_on_produto_id"
    t.index ["supermercado_id"], name: "index_produtos_precos_on_supermercado_id"
  end

  create_table "supermercados", id: :serial, force: :cascade do |t|
    t.string "nome_mercado", limit: 255, null: false
    t.string "website", limit: 255
    t.string "localizacao", limit: 255
    t.string "horario_funcionamento", limit: 255
    t.datetime "created_at", precision: nil, default: -> { "now()" }
    t.datetime "updated_at", precision: nil, default: -> { "now()" }
  end

  add_foreign_key "produtos_precos", "produtos"
  add_foreign_key "produtos_precos", "supermercados"
end
