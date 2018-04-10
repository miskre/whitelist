class Wallet::NationalIdCardKycPaper < ::Kyc
  validates_attachment(
    :face_and_national_id_card,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    unless: :is_save_base_info?
  )
  validates :face_and_national_id_card, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :national_id_card,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    unless: :is_save_base_info?
  )
  validates :national_id_card, attachment_presence: true, on: :for_user, unless: :is_save_base_info?

  validates_attachment(
    :national_id_card_reverse,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    unless: :is_save_base_info?
  )
  validates :national_id_card_reverse, attachment_presence: true, on: :for_user, unless: :is_save_base_info?
  validates :national_id_card_number, presence: true, on: :for_user, format: { with: CARD_NUMBER_ONLY}, unless: :is_save_base_info?

end
