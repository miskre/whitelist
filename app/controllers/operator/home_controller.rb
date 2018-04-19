class Operator::HomeController < Operator::BaseController
  def index
    users = ::User.all
    @total_user = users.size
    kycs = ::Kyc.all
    @submit_kyc = kycs.size
    @kyc_approved = kycs.accepted.size
    @kyc_rejected = kycs.rejected.size
    @kyc_pending = kycs.pending.size
    @not_submit_kyc = @total_user - @submit_kyc
    @confirmed_email = users.where(email_confirmed: true).size
    @not_confirmed_email = @total_user - @confirmed_email

    @amount_range_all = kycs.select("amount_range, count(amount_range) as count").group(:amount_range)
    @amount_range_accepted = kycs.accepted.select("amount_range, count(amount_range) as count").group(:amount_range)
  end
end
