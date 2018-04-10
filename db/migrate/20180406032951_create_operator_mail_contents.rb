class CreateOperatorMailContents < ActiveRecord::Migration
  def change
    create_table :operator_mail_contents do |t|
      t.integer :kind
      t.string :subject
      t.text :body

      t.timestamps null: false
    end
  end
end
