class AddBtcAddressToKyc < ActiveRecord::Migration
  def change
    add_column :kycs, :btc_address, :string
    add_column :kycs, :amount_range, :integer
  end
end
