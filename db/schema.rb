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

ActiveRecord::Schema[7.0].define(version: 2023_04_18_071534) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contest_sessions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "test_id"
    t.string "session_code"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_contents", force: :cascade do |t|
    t.integer "test_id"
    t.string "testable_type", null: false
    t.bigint "testable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["testable_type", "testable_id"], name: "index_test_contents_on_testable"
  end

  create_table "test_multiple_choice_answers", force: :cascade do |t|
    t.integer "test_multiple_choice_id"
    t.string "answer"
    t.float "score"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_multiple_choices", force: :cascade do |t|
    t.string "file_path"
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "time_to_do"
    t.integer "time_start"
    t.integer "time_end"
    t.boolean "do_once"
    t.string "password"
    t.integer "prevent_cheat"
    t.integer "show_mark"
    t.integer "show_answer"
    t.integer "version"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
