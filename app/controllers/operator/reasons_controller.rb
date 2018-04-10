class Operator::ReasonsController < Operator::BaseController
	before_action :set_reason, only: [:edit, :update, :destroy]
	def index
		@reasons = Operator::Reason.all
	end

	def new
		@operator_reason = Operator::Reason.new
	end

	def create
		@operator_reason = Operator::Reason.new(reason_params)
		if @operator_reason.save
			redirect_to operator_reasons_path, flash: {success: t('helpers.messages.executed')}
		else
			flash[:error] = t('helpers.messages.failed')
      render :new
		end
	end

	def update
		@operator_reason.update(reason_params)
		redirect_to operator_reasons_path, flash: {success: t('helpers.messages.executed')}
	end

	def destroy
		@operator_reason.destroy
		redirect_to operator_reasons_path, flash: {success: t('helpers.messages.executed')}
	end

	private
	def reason_params
		params.require(:operator_reason).permit(:content)
	end

	def set_reason
		@operator_reason = Operator::Reason.find params[:id]
	end
end