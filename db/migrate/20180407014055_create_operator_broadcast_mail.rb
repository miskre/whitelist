class CreateOperatorBroadcastMail < ActiveRecord::Migration
  def change
    create_table :operator_broadcast_mails do |t|
      t.string   :subject
      t.text     :body
      t.boolean  :send_all_customers
      t.timestamps null: false
    end
  end
end
