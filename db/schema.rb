# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_08_232809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clientes", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", null: false
    t.string "cpf", null: false
    t.integer "rg", null: false
    t.string "endereco", null: false
    t.date "data_nascimento"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password"
    t.index ["nome", "email", "cpf", "rg"], name: "index_clientes_on_nome_and_email_and_cpf_and_rg", unique: true
  end

  create_table "contas", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.integer "numero", null: false
    t.decimal "saldo", null: false
    t.date "data_abertura", null: false
    t.integer "tipo", null: false
    t.date "data_encerramento"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cliente_id"], name: "index_contas_on_cliente_id"
  end

  create_table "legacy_session_table", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_legacy_session_table_on_session_id", unique: true
    t.index ["updated_at"], name: "index_legacy_session_table_on_updated_at"
  end

  create_table "transferencias", force: :cascade do |t|
    t.bigint "cliente_id"
    t.bigint "conta_id"
    t.integer "tipo", null: false
    t.decimal "valor", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "saldo_conta"
    t.decimal "tarifa"
    t.index ["cliente_id"], name: "index_transferencias_on_cliente_id"
    t.index ["conta_id"], name: "index_transferencias_on_conta_id"
  end

end
