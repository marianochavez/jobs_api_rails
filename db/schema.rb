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

ActiveRecord::Schema[7.0].define(version: 2022_04_26_191305) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidate_job_listings", force: :cascade do |t|
    t.bigint "candidate_id"
    t.bigint "job_listing_id"
    t.integer "state", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_candidate_job_listings_on_candidate_id"
    t.index ["job_listing_id"], name: "index_candidate_job_listings_on_job_listing_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "address"
    t.string "phone"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_listings", force: :cascade do |t|
    t.bigint "company_id"
    t.string "title"
    t.text "description"
    t.date "start_date"
    t.string "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_job_listings_on_company_id"
  end

end
