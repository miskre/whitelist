class Account::PasswordResetController < Account::BaseController
  skip_before_action :enforce_sign_in

  def new
  end

  def create
    user = ::User.find_by(email: params[:email])
    if user
      @password_reset_token = user.password_reset_tokens.new
      if @password_reset_token.save!
        Operator::GeneralMailer.send_mail_content(Operator::MailContent.job_params(kind: :password_reset_request, obj: @password_reset_token)).deliver_later
        render action: :mail_sent
      end
    else
      flash.now[:error] = "We already sent reset password token to your email"
      render action: :new
    end
  end

  def mail_sent
  end

  def show
    token = params[:token]
    @prt = ::PasswordResetToken.available.find_by(token: token)
    if @prt.present?
      render action: :show
    else
      flash.now[:error] = "this link is no longer available"
      render action: :new
    end
  end

  def update
    @prt = PasswordResetToken.find_by(token: params[:wallet_password_reset_token][:token])
    if @prt.present?
      user = @prt.user
      user.assign_attributes(user_passwords)
      user.agreed = true
      if user.save
        @prt.destroy!

        flash[:success] = "Your password is successfully updated"
        redirect_to account_sign_in_path
      else
        flash[:error] = "Your inputs may be wrong"
        render action: :show
      end
    else
      flash[:error] = "this link is no longer available"
      redirect_to '/'
    end
  end

  private
    def user_passwords
      params.require(:wallet_user).permit(:password, :password_confirmation)
    end
end
