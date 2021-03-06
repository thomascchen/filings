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

ActiveRecord::Schema.define(version: 2021_08_01_234357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.integer "cash_amount", null: false
    t.string "purpose", null: false
    t.bigint "filer_id"
    t.bigint "filing_id"
    t.bigint "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["filer_id"], name: "index_awards_on_filer_id"
    t.index ["filing_id"], name: "index_awards_on_filing_id"
    t.index ["receiver_id"], name: "index_awards_on_receiver_id"
  end

  create_table "filers", force: :cascade do |t|
    t.integer "ein", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "street", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
  end

  create_table "filings", force: :cascade do |t|
    t.string "url", null: false
    t.xml "xml", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "filer_id"
    t.integer "tax_year", null: false
    t.boolean "amended", default: false
    t.index ["filer_id"], name: "index_filings_on_filer_id"
  end

  create_table "receivers", force: :cascade do |t|
    t.string "ein"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "street", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
  end

end
