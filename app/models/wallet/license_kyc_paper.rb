class Wallet::LicenseKycPaper < ::Kyc
  validates_attachment(
    :face_and_license,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    unless: :is_save_base_info?
  )
  validates :face_and_license, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :license,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    unless: :is_save_base_info?
  )
  validates :license, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :license_reverse,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    unless: :is_save_base_info?
  )
  validates :license_reverse, attachment_presence: true, on: :for_user, unless: :is_save_base_info?
  validates :license_number, presence: true, on: :for_user, format: { with: CARD_NUMBER_ONLY}, unless: :is_save_base_info?
end
