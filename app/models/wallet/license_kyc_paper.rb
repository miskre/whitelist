class Wallet::LicenseKycPaper < ::Kyc
  validates_attachment(
    :face_and_license,
    size: { less_than: 5.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif)$/ },
    unless: :is_save_base_info?
  )
  validates :face_and_license, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :license,
    size: { less_than: 5.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif)$/ },
    unless: :is_save_base_info?
  )
  validates :license, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :license_reverse,
    size: { less_than: 5.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif)$/ },
    unless: :is_save_base_info?
  )
  validates :license_reverse, attachment_presence: true, on: :for_user, unless: :is_save_base_info?
  validates :license_number, presence: true, uniqueness: true, on: :for_user, format: { with: CARD_NUMBER_ONLY}, unless: :is_save_base_info?
end
