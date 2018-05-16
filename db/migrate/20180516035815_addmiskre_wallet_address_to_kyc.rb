class AddmiskreWalletAddressToKyc < ActiveRecord::Migration
  def change
    add_column :kycs, :miskre_wallet_address, :string
  end
end
