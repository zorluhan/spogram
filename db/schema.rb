# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160318191343) do

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "username"
    t.string   "uid"
    t.integer  "branduser_id"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brandusers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fullname"
    t.string   "phone"
    t.string   "country"
    t.string   "password_digest"
    t.string   "cowebsite"
    t.string   "coname"
    t.string   "email"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "comsize"
    t.string   "title"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "auth_token"
    t.boolean  "is_authenticated",   default: false
  end

  create_table "charges", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "instauser_id"
    t.integer  "branduser_id"
    t.integer  "amount"
    t.string   "customer"
    t.string   "useremail"
    t.boolean  "is_read",             default: false
    t.string   "state"
    t.string   "product_name",        default: ""
    t.string   "product_link",        default: ""
    t.text     "product_description"
    t.text     "post_description"
    t.text     "suggested_caption"
    t.text     "hash_tags"
    t.text     "user_names"
    t.date     "earliest_post_date"
    t.date     "last_post_date"
    t.string   "instagram_link",      default: ""
  end

  add_index "charges", ["branduser_id"], name: "index_charges_on_branduser_id"
  add_index "charges", ["instauser_id"], name: "index_charges_on_instauser_id"
  add_index "charges", ["state"], name: "index_charges_on_state"

  create_table "instaposts", force: true do |t|
    t.integer  "instauser_id",                       null: false
    t.string   "media_thumb_url"
    t.string   "media_standard_url"
    t.date     "media_date"
    t.boolean  "most_liked",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes_counts",       default: 0
  end

  create_table "instausers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fullname"
    t.string   "username"
    t.string   "email"
    t.string   "location"
    t.integer  "age"
    t.string   "theme"
    t.integer  "postprice"
    t.integer  "averagelikes"
    t.integer  "averagecomments"
    t.integer  "followed_by"
    t.text     "profile_picture"
    t.text     "recent_media_urls"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "access_token"
    t.float    "engagementscore",               default: 0.0
    t.datetime "last_updated"
    t.boolean  "disabled",                      default: true
    t.string   "paypal_email"
    t.boolean  "send_email",                    default: true
    t.string   "passion"
    t.text     "bio",               limit: 255
    t.date     "dob"
    t.string   "checkvalidation"
    t.string   "auth_token"
    t.boolean  "is_authenticated",              default: false
  end

  create_table "messages", force: true do |t|
    t.integer  "sender"
    t.integer  "instauser_id"
    t.integer  "branduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "message"
    t.boolean  "is_read",      default: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
