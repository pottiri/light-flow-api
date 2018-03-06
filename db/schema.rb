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

ActiveRecord::Schema.define(version: 20180306125824) do

  create_table "approve_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "status", null: false, comment: "ステータス(0:未実行,10:実行中,20:実行済,30:棄却,40:前方スキップ,41:後方スキップ)"
    t.text "comment"
    t.bigint "approver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approver_id"], name: "index_approve_histories_on_approver_id"
  end

  create_table "approvers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "user_id", null: false
    t.bigint "step_approver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_approver_id"], name: "index_approvers_on_step_approver_id"
  end

  create_table "current_approve_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "approver_id", null: false
    t.bigint "approve_history_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approve_history_id"], name: "index_current_approve_histories_on_approve_history_id"
    t.index ["approver_id"], name: "index_current_approve_histories_on_approver_id"
  end

  create_table "current_step_approvers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "step_id", null: false
    t.bigint "step_approver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_approver_id"], name: "index_current_step_approvers_on_step_approver_id"
    t.index ["step_id"], name: "index_current_step_approvers_on_step_id"
  end

  create_table "flows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.json "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "step_approvers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "step_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_id"], name: "index_step_approvers_on_step_id"
  end

  create_table "steps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "step_num", null: false
    t.bigint "flow_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flow_id"], name: "index_steps_on_flow_id"
  end

  add_foreign_key "approve_histories", "approvers", on_delete: :cascade
  add_foreign_key "approvers", "step_approvers", on_delete: :cascade
  add_foreign_key "current_approve_histories", "approve_histories", on_delete: :cascade
  add_foreign_key "current_approve_histories", "approvers", on_delete: :cascade
  add_foreign_key "current_step_approvers", "step_approvers", on_delete: :cascade
  add_foreign_key "current_step_approvers", "steps", on_delete: :cascade
  add_foreign_key "step_approvers", "steps", on_delete: :cascade
  add_foreign_key "steps", "flows", on_delete: :cascade
end
