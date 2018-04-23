module Operator
  class GeneralMailer < ApplicationMailer
    def send_mail_content(params)
      params[:kind] = params[:kind].to_sym

      content = MailContent.find_by(kind: MailContent.kinds[params[:kind]])
      @subject = content.parse_subject(params[:rep])
      @body = content.parse_body(params[:rep])

      mail from: Settings.email_from,
        to: params[:email],
        subject: @subject,
        bcc: Settings.email_from,
        return_path: Settings.email_from
    end

    def simple_mail(email, subject, body)
      @email = email
      @subject = subject
      @body = body
      mail from: Settings.email_from,
        to: @email,
        subject: @subject,
        bcc: Settings.email_from,
        return_path: Settings.email_from
    end
  end
end
