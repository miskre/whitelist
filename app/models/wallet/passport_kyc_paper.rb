class Wallet::PassportKycPaper < ::Kyc
  validates_attachment(
    :face_and_passport,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    unless: :is_save_base_info?
  )
  validates :face_and_passport, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :passport,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    unless: :is_save_base_info?
  )
  validates :passport, attachment_presence: true, on: :for_user, unless: :is_save_base_info?
  validates :passport_number, presence: true, on: :for_user, format: { with: PASSPORT_ONLY}, unless: :is_save_base_info?
end
