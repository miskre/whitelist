class Operator::BroadcastMailsController < Operator::BaseController
  def index
    @broadcast_mails = Operator::BroadcastMail.order(created_at: :desc).page(params[:page])
  end

  def new
    @broadcast_mail = Operator::BroadcastMail.new
  end

  def create
    @broadcast_mail = Operator::BroadcastMail.new broadcast_mail_params
    if @broadcast_mail.send_all_customers
      @broadcast_mail.assign_attributes(user_ids: nil)
    end
    if @broadcast_mail.save
      @broadcast_mail.broadcast
      redirect_to operator_broadcast_mails_path
    else
      render :new
    end
  end

  def show
    @broadcast_mail = Operator::BroadcastMail.find(params[:id])
  end

  private
    def broadcast_mail_params
      params.require(:operator_broadcast_mail).permit(
        :subject,
        :body,
        :send_all_customers,
        user_ids: []
        )
    end
end