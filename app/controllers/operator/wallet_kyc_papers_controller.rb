class Operator::WalletKycPapersController < Operator::BaseController
  before_action :set_wallet_user, only: [:new, :edit, :create, :update, :destroy]

  def new
    @wallet_kyc_paper = ::Kyc.new
  end

  def edit
  end

  def create
    @wallet_kyc_paper = @wallet_user.build_kyc(wallet_kyc_paper_params)
    @wallet_kyc_paper.status = "pending"
    @wallet_kyc_paper.operator_save = true
    if @wallet_kyc_paper.save
      redirect_to operator_wallet_user_path(@wallet_user), flash: {success: 'successfully created.'}
    else
      render :new
    end
  end

  def update
    @wallet_kyc_paper.status = "pending"
    @wallet_kyc_paper.assign_attributes(wallet_kyc_paper_params)
    @wallet_kyc_paper.operator_save = true
    if @wallet_kyc_paper.save(context: :for_user)
      redirect_to operator_wallet_user_path(@wallet_user), flash: {success: 'successfully updated.'}
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet_user
      @wallet_user = ::User.find(params[:wallet_user_id])
      @wallet_kyc_paper = @wallet_user.kyc
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wallet_kyc_paper_params
      params.require(:wallet_kyc_paper).permit(
        :type,
        :country,
        :full_name,
        :street,
        :street2,
        :city,
        :region,
        :birth_date,
        :face_and_passport,
        :passport,
        :passport_number,
        :face_and_license,
        :license,
        :license_reverse,
        :license_number,
        :national_id_card,
        :national_id_card_reverse,
        :face_and_national_id_card,
        :national_id_card_number,
        :btc_address,
        :amount_range
      )
    end
end
