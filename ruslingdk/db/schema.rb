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

ActiveRecord::Schema.define(version: 20171031191459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "educational_domains", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_educational_domains_on_domain"
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

end
