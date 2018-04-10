module Operator
  class KycPendingWalletUsersController < BaseController
    before_action :set_kyc_pending_wallet_user, only: [:show, :edit, :update, :destroy]

    def index
      kyc_pending_ids = ::Kyc.where(status: 0).order(updated_at: :desc).pluck(:user_id).uniq
      kyc_pending = ::User.where(id: kyc_pending_ids)
      @kyc_pending_wallet_users = kyc_pending.none? ? kyc_pending.page(params[:page]) :  kyc_pending.order("field(id, #{kyc_pending_ids.join ','})").includes(:kyc).page(params[:page])
      @kyc_not_submit_wallet_users = ::User.where.not(id: ::Kyc.pluck(:user_id).uniq)
    end

    def edit
      @kyc_paper = @kyc_pending_wallet_user.kyc
      @reasons = Operator::Reason.all
    end

    def update
      if params[:accept]
        @kyc_pending_wallet_user.kyc.update(status: :accepted)
        Operator::GeneralMailer.send_mail_content(Operator::MailContent.job_params(kind: :opening_account_complete, obj: @kyc_pending_wallet_user)).deliver
        redirect_to @next_kyc&.kyc&.status == "pending" ? edit_operator_kyc_pending_wallet_user_path(@next_kyc) : operator_kyc_pending_wallet_users_path, flash: {success: 'Kyc pending wallet user was successfully acceped.'}
      elsif params[:reject] && params[:reason].present?
        @kyc_pending_wallet_user.kyc.update(status: :rejected, message: params[:reason])
        Operator::GeneralMailer.send_mail_content(Operator::MailContent.job_params(kind: :kyc_reject, obj: @kyc_pending_wallet_user)).deliver
        redirect_to @next_kyc&.kyc&.status == "pending" ? edit_operator_kyc_pending_wallet_user_path(@next_kyc) : operator_kyc_pending_wallet_users_path, flash: {success: 'Kyc pending wallet user was successfully rejected.'}
      else
        redirect_to operator_kyc_pending_wallet_users_path, flash: {warning: 'Illegal access.'}
      end
    end

    private
      def set_kyc_pending_wallet_user
        @kyc_pending_wallet_user = ::User.find(params[:id])
        @next_kyc = ::User.where("id > ?", @kyc_pending_wallet_user.id).first
        @prev_kyc = ::User.where("id < ?", @kyc_pending_wallet_user.id).last
      end
  end
end
