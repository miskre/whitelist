class Operator::WalletUsersController < Operator::BaseController
  before_action :set_wallet_user, only: [:show, :edit, :update, :destroy, :create_card, :xsystem_type]
  before_action :validate_for_wc, only: :create_card

  SUCCESS     = '0'
  KYC_SUCCESS = '130084'

  def index
    @users = ::User.all.unscope(where: :deleted_at)
  end

  def new
    @wallet_user = ::User.new
  end

  def show
    
  end

  def create
    @wallet_user = ::User.new(wallet_user_params)
    @wallet_user.agreed = true
    if @wallet_user.save
      redirect_to operator_wallet_users_path, flash: {success: 'successfully created.'}
    else
      render action: :new
    end
  end

  def edit
    @wallet_user = ::User.find(params[:id])
  end

  def update
    @wallet_user.assign_attributes(wallet_user_params)
    @wallet_user.agreed = true
    if @wallet_user.save
      redirect_to operator_wallet_user_path(@wallet_user), flash: {success: 'successfully updated.'}
    else
      render :edit
    end
  end

  def destroy
    @wallet_user.remove
    redirect_to :back
  end

  def user_address
    @wallet_user = Wallet::User.find(params[:id])
    if kyc_paper = @wallet_user.kyc_paper
      render json: {
        userAddress: {
          addressLineOne: kyc_paper.street,
          city:           kyc_paper.city,
          zipCode:        kyc_paper.postal_code,
          country:        kyc_paper.country
        }
      }
    else
      render status: 400
    end
  end


  private

    def set_wallet_user
      @wallet_user = ::User.unscope(where: :deleted_at).find(params[:id])
    end

    def wallet_user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :email_confirmed).delete_if {|k, v| v == ""}
    end

end
