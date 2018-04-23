class Wallet::PassportKycPaper < ::Kyc
  validates_attachment(
    :face_and_passport,
    size: { less_than: 5.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif)$/ },
    unless: :is_save_base_info?
  )
  validates :face_and_passport, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :passport,
    size: { less_than: 5.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif)$/ },
    unless: :is_save_base_info?
  )
  validates :passport, attachment_presence: true, on: :for_user, unless: :is_save_base_info?
  validates :passport_number, presence: true, uniqueness: true, on: :for_user, format: { with: PASSPORT_ONLY}, unless: :is_save_base_info?
end
