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
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "albums", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "location",    limit: 255
    t.integer  "parent",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "attachment_for_type", limit: 255
    t.integer  "attachment_for_id",   limit: 4
    t.string   "file",                limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "item_order",  limit: 4
    t.integer  "parent_id",   limit: 4
    t.string   "link",        limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body",             limit: 65535
    t.string   "title",            limit: 255
    t.integer  "user_id",          limit: 4
    t.string   "email",            limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "comment_for_id",   limit: 4
    t.string   "comment_for_type", limit: 255
  end

  create_table "file_uploads", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "location",    limit: 255
    t.string   "size_small",  limit: 255
    t.string   "size_medium", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "photos", force: :cascade do |t|
    t.text     "exif_info",          limit: 65535
    t.text     "about",              limit: 65535
    t.string   "location",           limit: 255
    t.string   "title",              limit: 255
    t.string   "thumbnail_location", limit: 255
    t.integer  "album_id",           limit: 4
    t.string   "filename",           limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "plugins", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "priority",    limit: 4
    t.string   "plugin_type", limit: 255
    t.string   "file_name",   limit: 255
    t.integer  "line_number", limit: 4
    t.string   "class_name",  limit: 255
    t.string   "method_name", limit: 255
    t.string   "hook_name",   limit: 255
    t.integer  "num_args",    limit: 4
    t.text     "options",     limit: 65535
    t.boolean  "active"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "context",     limit: 255,   default: "*"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "body",        limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "account_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.string   "path",        limit: 255
    t.boolean  "is_news",                   default: false
    t.boolean  "published",                 default: false
  end

  create_table "preferences", force: :cascade do |t|
    t.integer  "account_id", limit: 4
    t.string   "context",    limit: 255,   default: "*"
    t.string   "key",        limit: 255
    t.text     "value",      limit: 65535
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
