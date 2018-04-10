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

ActiveRecord::Schema.define(version: 20180410065744) do

  create_table "kycs", force: :cascade do |t|
    t.date     "birth_date"
    t.string   "country",                                limit: 255
    t.string   "region",                                 limit: 255
    t.string   "city",                                   limit: 255
    t.string   "street",                                 limit: 255
    t.string   "street2",                                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                limit: 4
    t.integer  "status",                                 limit: 4
    t.text     "message",                                limit: 65535
    t.string   "passport_file_name",                     limit: 255
    t.string   "passport_content_type",                  limit: 255
    t.integer  "passport_file_size",                     limit: 4
    t.datetime "passport_updated_at"
    t.string   "face_and_passport_file_name",            limit: 255
    t.string   "face_and_passport_content_type",         limit: 255
    t.integer  "face_and_passport_file_size",            limit: 4
    t.datetime "face_and_passport_updated_at"
    t.string   "license_file_name",                      limit: 255
    t.string   "license_content_type",                   limit: 255
    t.integer  "license_file_size",                      limit: 4
    t.datetime "license_updated_at"
    t.string   "license_reverse_file_name",              limit: 255
    t.string   "license_reverse_content_type",           limit: 255
    t.integer  "license_reverse_file_size",              limit: 4
    t.datetime "license_reverse_updated_at"
    t.string   "face_and_license_file_name",             limit: 255
    t.string   "face_and_license_content_type",          limit: 255
    t.integer  "face_and_license_file_size",             limit: 4
    t.datetime "face_and_license_updated_at"
    t.string   "national_id_card_file_name",             limit: 255
    t.string   "national_id_card_content_type",          limit: 255
    t.integer  "national_id_card_file_size",             limit: 4
    t.datetime "national_id_card_updated_at"
    t.string   "national_id_card_reverse_file_name",     limit: 255
    t.string   "national_id_card_reverse_content_type",  limit: 255
    t.integer  "national_id_card_reverse_file_size",     limit: 4
    t.datetime "national_id_card_reverse_updated_at"
    t.string   "face_and_national_id_card_file_name",    limit: 255
    t.string   "face_and_national_id_card_content_type", limit: 255
    t.integer  "face_and_national_id_card_file_size",    limit: 4
    t.datetime "face_and_national_id_card_updated_at"
    t.string   "type",                                   limit: 255
    t.string   "full_name",                              limit: 255
    t.string   "passport_number",                        limit: 255
    t.string   "national_id_card_number",                limit: 255
    t.string   "license_number",                         limit: 255
    t.string   "btc_address",                            limit: 255
    t.integer  "amount_range",                           limit: 4
  end

  add_index "kycs", ["user_id"], name: "index_kycs_on_user_id", using: :btree

  create_table "operator_broadcast_mails", force: :cascade do |t|
    t.string   "subject",            limit: 255
    t.text     "body",               limit: 65535
    t.boolean  "send_all_customers"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "operator_mail_contents", force: :cascade do |t|
    t.integer  "kind",       limit: 4
    t.string   "subject",    limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "operator_maintenance_settings", force: :cascade do |t|
    t.boolean "enabled",               default: false
    t.text    "message", limit: 65535
  end

  create_table "operator_reasons", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "operator_reasons", ["content"], name: "index_operator_reasons_on_content", using: :btree

  create_table "operator_user_b_mails", force: :cascade do |t|
    t.integer  "user_id",                    limit: 4
    t.integer  "operator_broadcast_mail_id", limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "operator_user_b_mails", ["operator_broadcast_mail_id"], name: "index_operator_user_b_mails_on_operator_broadcast_mail_id", using: :btree
  add_index "operator_user_b_mails", ["user_id"], name: "index_operator_user_b_mails_on_user_id", using: :btree

  create_table "operator_users", force: :cascade do |t|
    t.string   "nickname",               limit: 255,                null: false
    t.string   "password_digest",        limit: 255,                null: false
    t.integer  "authority",              limit: 4,   default: 0
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "use_two_factor_auth",                default: true
    t.string   "two_factor_auth_secret", limit: 255
  end

  add_index "operator_users", ["authority"], name: "index_operator_users_on_authority", using: :btree
  add_index "operator_users", ["nickname"], name: "index_operator_users_on_nickname", unique: true, using: :btree

  create_table "password_reset_tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "password_reset_tokens", ["user_id"], name: "index_password_reset_tokens_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "password_digest",        limit: 255,                 null: false
    t.boolean  "email_confirmed",                    default: false, null: false
    t.string   "confirm_token",          limit: 255
    t.datetime "last_signed_in_at"
    t.boolean  "use_two_factor_auth",                default: false
    t.string   "two_factor_auth_secret", limit: 255
    t.time     "deleted_at"
    t.string   "otp_secret_key",         limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

end
