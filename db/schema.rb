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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anm_report_data", force: :cascade do |t|
    t.integer "anmidentifier", null: false
    t.string  "externalid",    null: false
    t.integer "indicator",     null: false
    t.date    "date_"
  end

  create_table "annual_target", force: :cascade do |t|
    t.integer "anmidentifier", null: false
    t.integer "indicator",     null: false
    t.string  "target",        null: false
    t.date    "start_date",    null: false
    t.date    "end_date",      null: false
  end

  add_index "annual_target", ["anmidentifier", "indicator", "start_date", "end_date"], name: "u_at_ai_in_ta_sd_ed", unique: true, using: :btree
  add_index "annual_target", ["service_provider", "indicator", "start_date", "end_date"], name: "u_at_sp_in_ta_sd_ed", unique: true, using: :btree

  create_table "annual_target", force: :cascade do |t|
    t.integer "anmidentifier", null: false
    t.integer "indicator",     null: false
    t.string  "target",        null: false
    t.date    "start_date",    null: false
    t.date    "end_date",      null: false
  end

  add_index "annual_target", ["anmidentifier", "indicator", "start_date", "end_date"], name: "u_at_ai_in_ta_sd_ed", unique: true, using: :btree
  add_index "annual_target", ["service_provider", "indicator", "start_date", "end_date"], name: "u_at_sp_in_ta_sd_ed", unique: true, using: :btree

  create_table "dim_anm", force: :cascade do |t|
    t.string "anmidentifier", null: false
  end

  add_index "dim_anm", ["anmidentifier"], name: "u_da_an", unique: true, using: :btree
  add_index "dim_anm", ["anmidentifier"], name: "u_da_an", unique: true, using: :btree

  create_table "dim_anm", force: :cascade do |t|
    t.string "anmidentifier", null: false
  end

  add_index "dim_anm", ["anmidentifier"], name: "u_da_an", unique: true, using: :btree
  add_index "dim_anm", ["anmidentifier"], name: "u_da_an", unique: true, using: :btree

  create_table "dim_indicator", force: :cascade do |t|
    t.string "indicator", null: false
  end

  add_index "dim_indicator", ["indicator"], name: "u_di_in", unique: true, using: :btree
  add_index "dim_indicator", ["indicator"], name: "u_di_in", unique: true, using: :btree

  create_table "dim_indicator", force: :cascade do |t|
    t.string "indicator", null: false
  end

  add_index "dim_indicator", ["indicator"], name: "u_di_in", unique: true, using: :btree
  add_index "dim_indicator", ["indicator"], name: "u_di_in", unique: true, using: :btree

  create_table "dim_location", force: :cascade do |t|
    t.string  "village",   null: false
    t.string  "subcenter", null: false
    t.integer "phc",       null: false
    t.string  "taluka",    null: false
    t.string  "district",  null: false
    t.string  "state",     null: false
  end

  add_index "dim_location", ["village", "subcenter", "phc", "taluka", "district", "state"], name: "u_dl_vi_su_ph_tk_dt_st", unique: true, using: :btree
  add_index "dim_location", ["village", "subcenter", "phc"], name: "u_dl_vi_su_ph", unique: true, using: :btree

  create_table "dim_phc", force: :cascade do |t|
    t.string "phcidentifier", null: false
    t.string "name",          null: false
  end

  add_index "dim_phc", ["phcidentifier"], name: "u_dp_pi", unique: true, using: :btree

  create_table "dim_service_provider", force: :cascade do |t|
    t.integer "service_provider", null: false
    t.integer "type",             null: false
  end

  add_index "dim_service_provider", ["service_provider", "type"], name: "u_sp_ty", unique: true, using: :btree

  create_table "dim_service_provider_type", force: :cascade do |t|
    t.string "type", null: false
  end

  add_index "dim_service_provider_type", ["type"], name: "u_dspt_ty", unique: true, using: :btree

  create_table "schema_version", id: false, force: :cascade do |t|
    t.integer  "version_rank",                                  null: false
    t.integer  "installed_rank",                                null: false
    t.string   "version",        limit: 50,                     null: false
    t.string   "description",    limit: 200,                    null: false
    t.string   "type",           limit: 20,                     null: false
    t.string   "script",         limit: 1000,                   null: false
    t.integer  "checksum"
    t.string   "installed_by",   limit: 30,                     null: false
    t.datetime "installed_on",                default: "now()", null: false
    t.integer  "execution_time",                                null: false
    t.boolean  "success",                                       null: false
  end

  add_index "schema_version", ["installed_rank"], name: "schema_version_ir_idx", using: :btree
  add_index "schema_version", ["installed_rank"], name: "schema_version_ir_idx", using: :btree
  add_index "schema_version", ["success"], name: "schema_version_s_idx", using: :btree
  add_index "schema_version", ["success"], name: "schema_version_s_idx", using: :btree
  add_index "schema_version", ["version_rank"], name: "schema_version_vr_idx", using: :btree
  add_index "schema_version", ["version_rank"], name: "schema_version_vr_idx", using: :btree

  create_table "schema_version", id: false, force: :cascade do |t|
    t.integer  "version_rank",                                  null: false
    t.integer  "installed_rank",                                null: false
    t.string   "version",        limit: 50,                     null: false
    t.string   "description",    limit: 200,                    null: false
    t.string   "type",           limit: 20,                     null: false
    t.string   "script",         limit: 1000,                   null: false
    t.integer  "checksum"
    t.string   "installed_by",   limit: 30,                     null: false
    t.datetime "installed_on",                default: "now()", null: false
    t.integer  "execution_time",                                null: false
    t.boolean  "success",                                       null: false
  end

  add_index "schema_version", ["installed_rank"], name: "schema_version_ir_idx", using: :btree
  add_index "schema_version", ["installed_rank"], name: "schema_version_ir_idx", using: :btree
  add_index "schema_version", ["success"], name: "schema_version_s_idx", using: :btree
  add_index "schema_version", ["success"], name: "schema_version_s_idx", using: :btree
  add_index "schema_version", ["version_rank"], name: "schema_version_vr_idx", using: :btree
  add_index "schema_version", ["version_rank"], name: "schema_version_vr_idx", using: :btree

  create_table "service_provided", force: :cascade do |t|
    t.integer "service_provider",  null: false
    t.string  "externalid",        null: false
    t.integer "indicator",         null: false
    t.integer "location",          null: false
    t.date    "date_"
    t.string  "dristhi_entity_id"
  end

  create_table "token", force: :cascade do |t|
    t.string "name",  null: false
    t.string "value", null: false
  end

  add_index "token", ["name"], name: "u_token_name", unique: true, using: :btree

  add_foreign_key "anm_report_data", "dim_anm", column: "anmidentifier", name: "fk_ard_da_id"
  add_foreign_key "anm_report_data", "dim_indicator", column: "indicator", name: "fk_ard_di_id"
  add_foreign_key "annual_target", "dim_anm", column: "anmidentifier", name: "fk_at_da_id"
  add_foreign_key "annual_target", "dim_indicator", column: "indicator", name: "fk_at_di_id"
  add_foreign_key "annual_target", "dim_service_provider", column: "service_provider", name: "fk_at_dsp_id"
  add_foreign_key "annual_target", "report.dim_indicator", column: "indicator", name: "fk_at_di_id"
  add_foreign_key "annual_target", "dim_anm", column: "anmidentifier", name: "fk_at_da_id"
  add_foreign_key "annual_target", "dim_indicator", column: "indicator", name: "fk_at_di_id"
  add_foreign_key "annual_target", "dim_service_provider", column: "service_provider", name: "fk_at_dsp_id"
  add_foreign_key "annual_target", "report.dim_indicator", column: "indicator", name: "fk_at_di_id"
  add_foreign_key "dim_anm", "dim_phc", column: "phc", name: "fk_da_dp_id"
  add_foreign_key "dim_anm", "dim_phc", column: "phc", name: "fk_da_dp_id"
  add_foreign_key "dim_location", "dim_phc", column: "phc", name: "fk_dl_dp_id"
  add_foreign_key "dim_service_provider", "dim_service_provider_type", column: "type", name: "fk_dsp_dst_id"
  add_foreign_key "service_provided", "dim_location", column: "location", name: "fk_sp_dl_id"
  add_foreign_key "service_provided", "dim_service_provider", column: "service_provider", name: "fk_sp_dsp_id"
  add_foreign_key "service_provided", "report.dim_indicator", column: "indicator", name: "fk_sp_di_id"
end
