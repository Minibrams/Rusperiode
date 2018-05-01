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

ActiveRecord::Schema.define(version: 20180501151311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "educational_domains", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "default_page_id"
    t.integer "primary_menu_id"
    t.integer "secondary_menu_id"
    t.jsonb "colors"
    t.index ["default_page_id"], name: "index_educational_domains_on_default_page_id"
    t.index ["domain"], name: "index_educational_domains_on_domain"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.bigint "educational_domain_id"
    t.string "description"
    t.string "location"
    t.decimal "lat", precision: 9, scale: 6
    t.decimal "lng", precision: 9, scale: 6
    t.datetime "begin_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["educational_domain_id"], name: "index_events_on_educational_domain_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.jsonb "items"
    t.bigint "educational_domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["educational_domain_id"], name: "index_menus_on_educational_domain_id"
  end

  create_table "oauth_logins", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "secret"
    t.datetime "expires_at"
    t.jsonb "raw_data"
    t.bigint "user_id"
    t.index ["expires_at"], name: "index_oauth_logins_on_expires_at"
    t.index ["provider"], name: "index_oauth_logins_on_provider"
    t.index ["token"], name: "index_oauth_logins_on_token"
    t.index ["uid"], name: "index_oauth_logins_on_uid"
    t.index ["user_id"], name: "index_oauth_logins_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "slug"
    t.string "title"
    t.text "content"
    t.bigint "educational_domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["educational_domain_id"], name: "index_pages_on_educational_domain_id"
    t.index ["slug"], name: "index_pages_on_slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["password_digest"], name: "index_users_on_password_digest"
  end

  add_foreign_key "educational_domains", "menus", column: "primary_menu_id", on_delete: :nullify
  add_foreign_key "educational_domains", "menus", column: "secondary_menu_id", on_delete: :nullify
  add_foreign_key "events", "educational_domains"
  add_foreign_key "menus", "educational_domains"
end
