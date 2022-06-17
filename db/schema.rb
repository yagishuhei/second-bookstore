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

ActiveRecord::Schema.define(version: 2022_06_17_013633) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.string "name"
    t.string "postal_code"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_addresses_on_end_user_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "category_id", null: false
    t.bigint "isbn"
    t.string "title"
    t.string "author"
    t.string "publisher_name"
    t.string "item_price"
    t.string "item_url"
    t.string "large_image_url"
    t.string "medium_image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["end_user_id"], name: "index_books_on_end_user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "sale_id", null: false
    t.integer "end_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_cart_items_on_end_user_id"
    t.index ["sale_id"], name: "index_cart_items_on_sale_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "end_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "last_name"
    t.string "first_name"
    t.string "last_name_kana"
    t.string "first_name_kana"
    t.string "nickname"
    t.text "introduction"
    t.string "postal_code"
    t.string "address"
    t.string "telephone_number"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_end_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_end_users_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "review_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_favorites_on_end_user_id"
    t.index ["review_id"], name: "index_favorites_on_review_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "sale_id", null: false
    t.integer "price"
    t.integer "shipping_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["sale_id"], name: "index_order_details_on_sale_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.string "postal_code"
    t.string "shipping_address"
    t.string "shipping_name"
    t.integer "shipping_cost"
    t.integer "total_payment"
    t.integer "payment_method"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_orders_on_end_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "review_comments", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "review_id", null: false
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_review_comments_on_end_user_id"
    t.index ["review_id"], name: "index_review_comments_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "book_id", null: false
    t.string "heading"
    t.text "blog"
    t.float "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["end_user_id"], name: "index_reviews_on_end_user_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "book_id", null: false
    t.text "introduction"
    t.integer "price"
    t.boolean "is_active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_sales_on_book_id"
    t.index ["end_user_id"], name: "index_sales_on_end_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "end_users"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "end_users"
  add_foreign_key "cart_items", "end_users"
  add_foreign_key "cart_items", "sales"
  add_foreign_key "favorites", "end_users"
  add_foreign_key "favorites", "reviews"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "sales"
  add_foreign_key "orders", "end_users"
  add_foreign_key "relationships", "end_users", column: "followed_id"
  add_foreign_key "relationships", "end_users", column: "follower_id"
  add_foreign_key "review_comments", "end_users"
  add_foreign_key "review_comments", "reviews"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "end_users"
  add_foreign_key "sales", "books"
  add_foreign_key "sales", "end_users"
end
