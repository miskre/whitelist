class Kyc < ActiveRecord::Base
  attr_accessor :save_base_info
  attr_accessor :operator_save
  belongs_to :user
	enum status: { pending: 0, accepted: 1, rejected: 2}
  default_value_for :type, 'Wallet::PassportKycPaper'

  VALID_ROMAN_REGEX = /\A|[a-zA-Z0-9# ,.-]+\z/
  ALPHABETS_NUMBERS_ONLY = /\A[a-zA-Z0-9 ]+\z/
  ALPHABETS_ONLY = /\A[a-zA-Z ]+\z/
  BTC_ADDRESS = /\A^[1-3][a-km-zA-HJ-NP-Z1-9]{25,34}$\z/
  CARD_NUMBER_ONLY = /\A[a-zA-Z0-9 -]+\z/
  PASSPORT_ONLY = /\A[a-zA-Z0-9]+\z/

  validates :country,          presence: true, if: :is_save_base_info?
  validates :full_name,        presence: true, format: { with: ALPHABETS_ONLY }, length: { maximum: 50 }, if: :is_save_base_info?
  validates :birth_date,       presence: true, if: :is_save_base_info?
  validates :street,           presence: true, format: { with: VALID_ROMAN_REGEX }, length: { maximum: 50 }, if: :is_save_base_info?
  validates :street2,          format: { with: VALID_ROMAN_REGEX}, length: { maximum: 50 }, if: :is_save_base_info?
  validates :city,             presence: true, format: { with: VALID_ROMAN_REGEX }, length: { in: 1..35 }, if: :is_save_base_info?
  validates :region, allow_blank: true, format: { with: ALPHABETS_NUMBERS_ONLY }, if: :is_save_base_info?
  validates :btc_address,      presence: true, format: { with: BTC_ADDRESS }, if: :is_save_base_info?

  has_attached_file :face_and_passport, unless: :is_save_base_info?
  has_attached_file :passport, unless: :is_save_base_info?
  has_attached_file :face_and_license, unless: :is_save_base_info?
  has_attached_file :license, unless: :is_save_base_info?
  has_attached_file :license_reverse, unless: :is_save_base_info?
  has_attached_file :national_id_card, unless: :is_save_base_info?
  has_attached_file :national_id_card_reverse, unless: :is_save_base_info?
  has_attached_file :face_and_national_id_card, unless: :is_save_base_info?

  private
    def is_save_base_info?
      self.save_base_info || self.operator_save
    end
end