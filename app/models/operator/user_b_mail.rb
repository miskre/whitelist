class Operator::UserBMail < ActiveRecord::Base
  belongs_to :user, class_name: "::User", foreign_key: :user_id
  belongs_to :operator_broadcast_mail, class_name: Operator::BroadcastMail, foreign_key: :operator_broadcast_mail_id
end
