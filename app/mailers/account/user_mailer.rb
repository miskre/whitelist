class Account::UserMailer < Account::ApplicationMailer
  def registration_confirmation(wallet_user)
    @wallet_user = wallet_user
    @host = Settings.default_url
    mail from: Settings.email_from,
      to: "#{@wallet_user.email}<#{@wallet_user.email}>",
      bcc: Settings.email_from,
      subject: "Please verify your email/メールアドレスのご確認",
      return_path: Settings.email_from
  end
end
