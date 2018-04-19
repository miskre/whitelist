class User < ActiveRecord::Base
  has_secure_password
	has_one :kyc
  has_many :operator_user_b_mails, class_name: Operator::UserBMail, foreign_key: :user_id
  has_many :operator_broadcast_mails, class_name: Operator::BroadcastMail, through: :operator_user_b_mails
  has_many :password_reset_tokens
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
  validates :agreed, presence: true,
    acceptance: {accept: true}

  before_create :set_confirmation_token
  
  def removed?
    return deleted_at != nil
  end

  def remove
    update!(deleted_at: Time.now)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  def update_last_signed_in_at
    self.update_attribute :last_signed_in_at, Time.zone.now
  end

  private
    def set_confirmation_token
      if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end