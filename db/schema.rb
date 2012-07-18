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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111206052211) do

  create_table "complexities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliverable_templates", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "phase_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_id"
  end

  create_table "deliverable_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unit_id"
    t.boolean  "adhoc"
  end

  add_index "deliverable_types", ["adhoc"], :name => "index_deliverable_types_on_adhoc"

  create_table "deliverables", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "phase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deliverable_type_id"
    t.boolean  "is_done",             :default => false
  end

  create_table "efforts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deliverable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_of_logging"
    t.float    "time_spent"
    t.float    "interrupt_time"
  end

  create_table "estimations", :force => true do |t|
    t.float    "productivity_rate"
    t.float    "effort"
    t.float    "size"
    t.integer  "deliverable_id"
    t.integer  "complexity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_updated",        :default => false
  end

  create_table "involvements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "involvements", ["project_id"], :name => "index_involvements_on_project_id"
  add_index "involvements", ["user_id"], :name => "index_involvements_on_user_id"

  create_table "life_cycles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phase_templates", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "life_cycle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "estimated_end_date"
    t.boolean  "is_finished"
    t.integer  "owner"
    t.integer  "life_cycle_id"
    t.boolean  "is_archived",        :default => false
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
