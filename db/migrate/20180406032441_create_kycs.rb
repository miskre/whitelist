class CreateKycs < ActiveRecord::Migration
  def change
    create_table :kycs do |t|
      t.date :birth_date
      t.string :gender
      t.string :country
      t.string :region
      t.string :city
      t.string :street
      t.string :street2

      t.timestamps
    end
    add_reference :kycs, :user, index: true
    add_column :kycs, :status, :integer
    add_column :kycs, :message, :text
    add_attachment :kycs, :passport
    add_attachment :kycs, :face_and_passport
    add_attachment :kycs, :license
    add_attachment :kycs, :license_reverse
    add_attachment :kycs, :face_and_license
    add_attachment :kycs, :national_id_card
    add_attachment :kycs, :national_id_card_reverse
    add_attachment :kycs, :face_and_national_id_card
    add_column :kycs, :type, :string
    add_column :kycs, :full_name, :string
    add_column :kycs, :passport_number, :string
    add_column :kycs, :national_id_card_number, :string
    add_column :kycs, :license_number, :string
  end
end
