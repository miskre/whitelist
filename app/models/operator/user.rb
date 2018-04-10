class Operator::User < ActiveRecord::Base
  bind_inum  :authority, Operator::Authority

  has_secure_password

  validates :nickname,
    presence: true,
    uniqueness: true,
    length: { in: 5..20 }

  def set_two_factor_auth_secret!
    self.two_factor_auth_secret = ROTP::Base32.random_base32
  end

  def generate_otp
    totp.now
  end

  def verify_otp(otp)
    totp.verify(otp)
  end

  def otp_provisioning_uri
    totp.provisioning_uri("One-time Password : #{self.nickname}")
  end
  
  private
    def totp
      @totp ||= ROTP::TOTP.new(self.two_factor_auth_secret)
    end
end
