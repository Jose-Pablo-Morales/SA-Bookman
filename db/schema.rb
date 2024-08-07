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

ActiveRecord::Schema[7.1].define(version: 2024_08_07_044756) do
  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.date "date_of_birth"
    t.string "country_of_origin"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.text "summary"
    t.date "publication_date"
    t.integer "number_of_sales"
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "book_id", null: false
    t.text "review"
    t.integer "score"
    t.integer "up_votes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "year"
    t.integer "sales"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_sales_on_book_id"
  end

  add_foreign_key "books", "authors"
  add_foreign_key "reviews", "books"
  add_foreign_key "sales", "books"
end