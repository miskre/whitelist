class Operator::BroadcastMail < ActiveRecord::Base
  include MailParsable
  attr_accessor :user_ids
  has_many :operator_user_b_mails, class_name: Operator::UserBMail, foreign_key: :operator_broadcast_mail_id
  has_many :users, class_name: "::User", through: :operator_user_b_mails 

  def broadcast
    if send_all_customers
      ::User.all.each do |user|
        Operator::GeneralMailer.simple_mail(*(mail_params(user))).deliver_later
      end
    else
      users = ::User.where(id: user_ids)
      users.each do |user|
        Operator::UserBMail.create(user_id: user.id, operator_broadcast_mail_id: id)
        Operator::GeneralMailer.simple_mail(*(mail_params(user))).deliver_later
      end
    end
  end

  def mail_params(user)
    rep = {
        "UserID" => user.try!(:id),
        "UserEmail" => user.try!(:email),
        "TimeNow" => Time.now
      }

    [user.email, parse_subject(rep), parse_body(rep)]
  end
end
