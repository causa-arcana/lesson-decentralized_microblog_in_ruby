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

ActiveRecord::Schema.define(version: 2021_03_10_102531) do

  create_table "followships", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "subject_profile_id", null: false
    t.integer "object_profile_id", null: false
    t.index ["object_profile_id"], name: "index_followships_on_object_profile_id"
    t.index ["subject_profile_id", "object_profile_id"], name: "index_followships_on_subject_profile_id_and_object_profile_id", unique: true
    t.index ["subject_profile_id"], name: "index_followships_on_subject_profile_id"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "profile_id", null: false
    t.string "text", null: false
    t.datetime "published_at", null: false
    t.index ["profile_id"], name: "index_posts_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "description"
  end

  add_foreign_key "followships", "profiles", column: "object_profile_id"
  add_foreign_key "followships", "profiles", column: "subject_profile_id"
  add_foreign_key "posts", "profiles"
end
