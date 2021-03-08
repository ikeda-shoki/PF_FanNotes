# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_08_094900) do

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_image_id"], name: "index_favorites_on_post_image_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "post_image_comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_image_id"
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_image_id"], name: "index_post_image_comments_on_post_image_id"
    t.index ["user_id"], name: "index_post_image_comments_on_user_id"
  end

  create_table "post_images", force: :cascade do |t|
    t.integer "user_id"
    t.string "image_id", null: false
    t.string "title", null: false
    t.text "image_introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_post_images_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "request_images", force: :cascade do |t|
    t.integer "request_id"
    t.string "complete_image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_request_images_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "requester_id"
    t.integer "requested_id"
    t.text "request_introduction", null: false
    t.string "reference_image_id"
    t.integer "file_format", default: 0, null: false
    t.text "use", null: false
    t.date "deadline", null: false
    t.integer "amount", default: 1, null: false
    t.integer "request_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requested_id"], name: "index_requests_on_requested_id"
    t.index ["requester_id"], name: "index_requests_on_requester_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "account_name", null: false
    t.text "user_introduction"
    t.boolean "is_reception", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_image_id"
    t.index ["account_name"], name: "index_users_on_account_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
