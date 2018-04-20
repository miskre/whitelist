class Account::UsersController < Account::BaseController
  skip_before_action :enforce_sign_in

  def new
    @wallet_user = ::User.new
  end

  def create
    @wallet_user = ::User.new(wallet_user_params)
    if verify_recaptcha(model: @wallet_user)
      @wallet_user.agreed = true if @wallet_user&.agreed == "on"
      if @wallet_user.save
        Account::UserMailer.registration_confirmation(@wallet_user).deliver_later
        redirect_to account_sign_in_path, flash: {success: t('helpers.messages.sign_up_mail_sended')}
      else
        flash.now[:error] = "Ooooppss, something went wrong!"
        render action: :new
      end
    else
      flash.now[:error] = "The data you entered for the CAPTCHA wasn't correct. Please try again!"
      render action: :new
    end
  end

  def confirm_email
    user = ::User.find_by_confirm_token(params[:id])
    if user
      ActiveRecord::Base.transaction do
        user.email_activate
        sign_in user

        redirect_to account_info_path, flash: {success: 'Welcome'}
      end
    else
      flash[:error] = "Sorry, this confirmation token incorrect."
      redirect_to account_root_path
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
