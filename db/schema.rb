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

ActiveRecord::Schema.define(version: 20180311125834) do

  create_table "person_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "person_event_class", null: false, comment: "承認イベント"
    t.text "comment"
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id", "person_event_class"], name: "index_person_events_on_person_id_and_person_event_class"
    t.index ["person_id"], name: "index_person_events_on_person_id"
  end

  create_table "flows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "creator_key"
    t.json "meta"
    t.datetime "create_datetime"
    t.datetime "application_datetime"
    t.datetime "archive_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "latest_person_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "person_id", null: false
    t.bigint "person_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_event_id"], name: "index_latest_person_events_on_person_event_id"
    t.index ["person_id", "person_event_id"], name: "index_latest_person_events_on_person_id_and_person_event_id", unique: true
    t.index ["person_id"], name: "index_latest_person_events_on_person_id"
  end

  create_table "latest_step_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "step_id", null: false
    t.bigint "step_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_event_id"], name: "index_latest_step_events_on_step_event_id"
    t.index ["step_id", "step_event_id"], name: "index_latest_step_events_on_step_id_and_step_event_id", unique: true
    t.index ["step_id"], name: "index_latest_step_events_on_step_id"
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "person_id", null: false
    t.bigint "step_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_event_id", "person_id"], name: "index_people_on_step_event_id_and_person_id", unique: true
    t.index ["step_event_id"], name: "index_people_on_step_event_id"
  end

  create_table "step_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "step_operator", null: false, comment: "演算子(10:AND,20:OR)"
    t.bigint "step_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_id"], name: "index_step_events_on_step_id"
  end

  create_table "steps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "step_order", null: false
    t.integer "step_class", null: false, comment: "ステップ区分(10:開始,20:承認,30:配信,90:終了)"
    t.bigint "flow_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flow_id", "step_class"], name: "index_steps_on_flow_id_and_step_class"
    t.index ["flow_id", "step_order"], name: "index_steps_on_flow_id_and_step_order", unique: true
    t.index ["flow_id"], name: "index_steps_on_flow_id"
  end

  add_foreign_key "person_events", "people", on_delete: :cascade
  add_foreign_key "latest_person_events", "person_events", on_delete: :cascade
  add_foreign_key "latest_person_events", "people", on_delete: :cascade
  add_foreign_key "latest_step_events", "step_events", on_delete: :cascade
  add_foreign_key "latest_step_events", "steps", on_delete: :cascade
  add_foreign_key "people", "step_events", on_delete: :cascade
  add_foreign_key "step_events", "steps", on_delete: :cascade
  add_foreign_key "steps", "flows", on_delete: :cascade
end
