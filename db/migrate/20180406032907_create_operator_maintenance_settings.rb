class CreateOperatorMaintenanceSettings < ActiveRecord::Migration
  def change
    create_table :operator_maintenance_settings do |t|
      t.boolean :enabled, default: false
      t.text :message
    end
  end
end
