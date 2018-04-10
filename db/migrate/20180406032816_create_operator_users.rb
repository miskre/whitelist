class CreateOperatorUsers < ActiveRecord::Migration
  def change
    create_table :operator_users do |t|
      t.string :nickname, :null => false
      t.string :password_digest , :null => false
      t.integer :authority, index: true, :default => 0

      t.timestamps null: false
    end
    add_index :operator_users, :nickname, unique: true
    add_column :operator_users, :use_two_factor_auth, :boolean, default: true
    add_column :operator_users, :two_factor_auth_secret, :string
  end
end
