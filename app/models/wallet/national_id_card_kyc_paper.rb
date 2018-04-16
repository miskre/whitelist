class Wallet::NationalIdCardKycPaper < ::Kyc
  validates_attachment(
    :face_and_national_id_card,
    size: { less_than: 5.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif)$/ },
    unless: :is_save_base_info?
  )
  validates :face_and_national_id_card, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :national_id_card,
    size: { less_than: 5.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif)$/ },
    unless: :is_save_base_info?
  )
  validates :national_id_card, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :national_id_card_reverse,
    size: { less_than: 5.megabytes },
    content_type: { content_type: /\Aimage\/(jpg|jpeg|png|gif)$/ },
    unless: :is_save_base_info?
  )
  validates :national_id_card_reverse, attachment_presence: true, on: :for_user, unless: :is_save_base_info?
  validates :national_id_card_number, presence: true, on: :for_user, format: { with: CARD_NUMBER_ONLY}, unless: :is_save_base_info?

end
