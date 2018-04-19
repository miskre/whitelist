class Kyc < ActiveRecord::Base
  attr_accessor :save_base_info
  attr_accessor :operator_save
  belongs_to :user
	enum status: { pending: 0, accepted: 1, rejected: 2}
  default_value_for :type, 'Wallet::PassportKycPaper'

  BTC_ADDRESS = /\A^[1-3][a-km-zA-HJ-NP-Z1-9]{25,34}$\z/
  CARD_NUMBER_ONLY = /\A[a-zA-Z0-9 -]+\z/
  PASSPORT_ONLY = /\A[a-zA-Z0-9]+\z/

  validates :country,          presence: true, if: :is_save_base_info?
  validates :full_name,        presence: true, length: { maximum: 70 }, if: :is_save_base_info?
  validates :birth_date,       presence: true, if: :is_save_base_info?
  validates :street,           presence: true, length: { maximum: 70 }, if: :is_save_base_info?
  validates :street2, allow_blank: true, length: { maximum: 70 }, if: :is_save_base_info?
  validates :city,             presence: true, length: { in: 2..35 }, if: :is_save_base_info?
  validates :region, allow_blank: true, length: { in: 2..35 }, if: :is_save_base_info?
  validates :btc_address,      presence: true, format: { with: BTC_ADDRESS }, if: :is_save_base_info?

  has_attached_file :face_and_passport, styles: { croppable: "400x400>" }, unless: :is_save_base_info?
  has_attached_file :passport, styles: { croppable: "400x400>" }, unless: :is_save_base_info?
  has_attached_file :face_and_license, styles: { croppable: "400x400>" }, unless: :is_save_base_info?
  has_attached_file :license, styles: { croppable: "400x400>" }, unless: :is_save_base_info?
  has_attached_file :license_reverse, styles: { croppable: "400x400>" }, unless: :is_save_base_info?
  has_attached_file :national_id_card, styles: { croppable: "400x400>" }, unless: :is_save_base_info?
  has_attached_file :national_id_card_reverse, styles: { croppable: "400x400>" }, unless: :is_save_base_info?
  has_attached_file :face_and_national_id_card, styles: { croppable: "400x400>" }, unless: :is_save_base_info?

  private
    def is_save_base_info?
      self.save_base_info || self.operator_save
    end
end