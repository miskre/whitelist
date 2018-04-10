class CreateOperatorReasons < ActiveRecord::Migration
  def change
    create_table :operator_reasons do |t|
      t.string :content

      t.timestamps null: false
    end
    add_index :operator_reasons, :content
  end
end
