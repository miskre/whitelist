# == Schema Information
#
# Table name: operator_mail_contents
#
#  id         :integer          not null, primary key
#  kind       :integer
#  subject    :string(255)
#  body       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Operator::MailContent < ActiveRecord::Base
  include MailParsable

  enum kind: {
    opening_account_complete: 1,
    login: 2,
    password_reset_request: 3,
    kyc_reject: 4,
    two_factor_auth: 5
  }

  validates :kind, uniqueness: true

  def self.job_params(params)
    case params[:kind]
    when :opening_account_complete
      user = params[:obj]
      rep = {
        "UserID" => user.try!(:id),
        "UserEmail" => user.try!(:email),
        "TimeNow" => Time.now
      }

      email = user.try!(:email)
    when :login
      user = params[:obj]
      rep = {
        "UserID" => user.try!(:id),
        "UserEmail" => user.try!(:email),
        "TimeNow" => Time.now
      }

      email = user.try!(:email)
    when :password_reset_request
      password_reset_token = params[:obj]
      user = password_reset_token.try!(:user)
      email = user.try!(:email)

      rep = {
        "Token" => password_reset_token.try!(:token),
        "UserID" => user.try!(:id),
        "UserEmail" => user.try!(:email),
        "TimeNow" => Time.now
      }
    when :kyc_reject
      user = params[:obj]
      kyc_paper = user.try!(:kyc)
      rep = {
        "UserID" => user.try!(:id),
        "UserEmail" => user.try!(:email),
        "KycMessage" => (eval(kyc_paper.try!(:message)).join("\n") if kyc_paper&.message.present?),
        "TimeNow" => Time.now
      }

      email = user.try!(:email)
    when :two_factor_auth
      user = params[:obj]
      rep = {
        "UserID" => user.try!(:id),
        "UserEmail" => user.try!(:email),
        "OneTimePassword" => user.try!(:generate_otp),
        "AvailableSeconds" => Settings.two_factor_auth.interval,
        "AvailableMinutes" => Settings.two_factor_auth.interval / 60,
        "ClosingTime"      => Time.now + Settings.two_factor_auth.interval.seconds,
        "TimeNow" => Time.now
      }

      email = user.try!(:email)
    end

    {rep: Hash[rep.map{ |key, item| [key, item.to_s]}], email: email, kind: params[:kind].to_s}
  end
end
