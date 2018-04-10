class Account::SessionsController < Account::BaseController
  skip_before_action :enforce_sign_in

  def new
  end

  def create
    user = ::User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.email_confirmed
        if user.use_two_factor_auth
          begin_two_factor_auth user
          Operator::GeneralMailer.send_mail_content(Operator::MailContent.job_params(kind: :two_factor_auth, obj: user)).deliver_now
          redirect_to action: :otp
        else
          sign_in user
          flash[:success] = 'You have logged in successfully !'
          Operator::GeneralMailer.send_mail_content(Operator::MailContent.job_params(kind: :login, obj: user)).deliver_now
          redirect_back_or account_root_path
        end
      else
        flash.now[:error] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render action: :new
      end
    else
      flash.now[:error] = "Invalid UserID or Password!"
      render action: :new
    end
  end

  def otp
  end

  def two_factor_auth
    if while_two_factor_auth?
      user = get_user_while_two_factor_auth
      if user.verify_otp(params[:session][:otp], fixed_time_for_two_factor_auth)
        sign_in_with_two_factor_auth user
        flash[:success] = 'You have logged in successfully !'
        Operator::GeneralMailer.send_mail_content(Operator::MailContent.job_params(kind: :login, obj: user)).deliver_later
        redirect_back_or wallet_root_path
      else
        flash.now[:error] = "Invalid One-time Password"
        render action: :otp
      end
    else
      flash.now[:error] = "Your two factor authentication seems to be timeout"
      render action: :new
    end
  end
  
  def destroy
    sign_out if signed_in?
    redirect_to account_sign_in_path
  end
end
