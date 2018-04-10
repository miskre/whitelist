class RemoveCorporateAccountAcceptedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :corporate_account_accepted, :boolean
  end
end
