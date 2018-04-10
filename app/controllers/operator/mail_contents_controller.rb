class Operator::MailContentsController < Operator::BaseController
  before_action :set_content, only: [:edit, :show, :update]

  def index
    @contents = Operator::MailContent.all
  end

  def edit
  end
  
  def update
    if @content.update(mail_content_params)
      redirect_to operator_mail_contents_path
    else
      redirect_to edit_operator_mail_content_path(@content.id)
    end
  end

  private
    def set_content
      @content = Operator::MailContent.find(params[:id])
    end

    def mail_content_params
      params.require(:operator_mail_content).permit(:subject, :body)
    end
end
