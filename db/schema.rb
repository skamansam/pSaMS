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

ActiveRecord::Schema.define(version: 22) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "surname",          limit: 255
    t.string   "email",            limit: 255
    t.string   "crypted_password", limit: 255
    t.string   "role",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description"
    t.string   "location",    limit: 255
    t.integer  "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "attachment_for_type"
    t.integer  "attachment_for_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_order"
    t.integer  "parent_id"
    t.string   "link",        limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.string   "title",            limit: 255
    t.integer  "user_id"
    t.string   "email",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_for_id"
    t.string   "comment_for_type"
  end

  create_table "file_uploads", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.string   "location",    limit: 255
    t.string   "size_small",  limit: 255
    t.string   "size_medium", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.text     "exif_info"
    t.text     "about"
    t.string   "location",           limit: 255
    t.string   "title",              limit: 255
    t.string   "thumbnail_location", limit: 255
    t.integer  "album_id"
    t.string   "filename",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plugins", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "priority"
    t.string   "plugin_type",   limit: 255
    t.string   "file_name",     limit: 255
    t.integer  "line_number"
    t.string   "class_name",    limit: 255
    t.string   "method_name",   limit: 255
    t.string   "hook_name",     limit: 255
    t.integer  "num_args"
    t.text     "options"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hook_location", limit: 255, default: "*"
    t.string   "context",                   default: "*"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.integer  "category_id"
    t.string   "path",        limit: 255
    t.boolean  "is_news",                 default: false
    t.boolean  "published",               default: false
  end

  create_table "preferences", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "context",    default: "*"
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

end
