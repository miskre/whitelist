# == Schema Information
#
# Table name: wallet_password_reset_tokens
#
#  id             :integer          not null, primary key
#  wallet_user_id :integer
#  token          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Wallet::PasswordResetToken < ActiveRecord::Base
  belongs_to :user, class_name: 'Wallet::User', foreign_key: :wallet_user_id

  scope :available, -> { where('created_at >= ?', 1.day.ago) }

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end
end
