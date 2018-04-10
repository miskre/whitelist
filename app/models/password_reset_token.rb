class PasswordResetToken < ActiveRecord::Base
  belongs_to :user

  scope :available, -> { where('created_at >= ?', 1.day.ago) }

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end

end