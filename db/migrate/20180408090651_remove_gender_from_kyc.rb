class RemoveGenderFromKyc < ActiveRecord::Migration
  def change
    remove_column :kycs, :gender, :string
  end
end
