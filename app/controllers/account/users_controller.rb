class Account::UsersController < Account::BaseController
  skip_before_action :enforce_sign_in

  def new
    @wallet_user = ::User.new
  end

  def create
    @wallet_user = ::User.new(wallet_user_params)
    @wallet_user.agreed = true if @wallet_user&.agreed == "on"
    if @wallet_user.save
      Account::UserMailer.registration_confirmation(@wallet_user).deliver_now
      redirect_to account_sign_in_path, flash: {success: t('helpers.messages.sign_up_mail_sended')}
    else
      render :new, flash: {error: "Ooooppss, something went wrong!"}
    end
  end

  def confirm_email
    user = ::User.find_by_confirm_token(params[:id])
    if user
      ActiveRecord::Base.transaction do
        user.email_activate
        sign_in user

        redirect_to account_root_path, flash: {success: 'Wellcome !!'}
      end
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to '/'
    end
  end


  private
    def wallet_user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :agreed
      )
    end
end
