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

ActiveRecord::Schema.define(version: 2018_06_08_144043) do

  create_table "fields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.text "contents"
    t.bigint "step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_id"], name: "index_fields_on_step_id"
    t.index ["type"], name: "index_fields_on_type"
  end

  create_table "journey_maps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 200
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_journey_maps_on_title"
  end

  create_table "steps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 100
    t.text "description"
    t.bigint "journey_map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journey_map_id"], name: "index_steps_on_journey_map_id"
    t.index ["title"], name: "index_steps_on_title"
  end

  add_foreign_key "fields", "steps"
  add_foreign_key "steps", "journey_maps"
end
