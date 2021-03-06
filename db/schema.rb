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

ActiveRecord::Schema.define(version: 20170111162529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "customers", force: :cascade do |t|
    t.string   "full_name"
    t.string   "address"
    t.text     "notes"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "user_id"
    t.uuid     "uuid",       default: "uuid_generate_v4()"
  end

  add_index "customers", ["user_id"], name: "index_customers_on_user_id", using: :btree

  create_table "job_tasks", force: :cascade do |t|
    t.string   "title"
    t.integer  "state",      default: 0,                    null: false
    t.integer  "job_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.uuid     "uuid",       default: "uuid_generate_v4()"
    t.text     "notes"
  end

  add_index "job_tasks", ["job_id"], name: "index_job_tasks_on_job_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.integer  "state",       default: 0,                    null: false
    t.integer  "customer_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.uuid     "uuid",        default: "uuid_generate_v4()"
    t.text     "notes"
  end

  add_index "jobs", ["customer_id"], name: "index_jobs_on_customer_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "customers", "users"
  add_foreign_key "job_tasks", "jobs"
  add_foreign_key "jobs", "customers"
end
