class OperatorUserBMails < ActiveRecord::Migration
  def change
    create_table "operator_user_b_mails", force: :cascade do |t|
      t.integer  "user_id",             limit: 4
      t.integer  "operator_broadcast_mail_id", limit: 4
      t.datetime "created_at",                           null: false
      t.datetime "updated_at",                           null: false
    end

    add_index "operator_user_b_mails", ["operator_broadcast_mail_id"], name: "index_operator_user_b_mails_on_operator_broadcast_mail_id", using: :btree
    add_index "operator_user_b_mails", ["user_id"], name: "index_operator_user_b_mails_on_user_id", using: :btree
  end
end
