class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest , :null => false
      t.boolean :email_confirmed, :null => false, :default => false
      t.string :confirm_token
      t.boolean :corporate_account_accepted, null: false
      t.datetime :last_signed_in_at
      t.boolean :use_two_factor_auth, default: false
      t.string :two_factor_auth_secret
      t.time :deleted_at
      t.string :otp_secret_key

      t.timestamps null: false
    end
  end
end
