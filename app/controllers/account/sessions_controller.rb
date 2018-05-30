class Account::SessionsController < Account::BaseController
  skip_before_action :enforce_sign_in
  
  def new
  end

  def create
    user = ::User.find_by_email(params[:session][:email])
    if verify_recaptcha(model: user) || ENV["RAILS_ENV"] == "development"
      if user && user.authenticate(params[:session][:password])
        if user.email_confirmed
          if params[:session][:remember_me].present?
            session[:remember_me] = true
          else
            session[:remember_me] = false
          end
          sign_in user
          flash[:success] = "You have logged in successfully!"
          Operator::GeneralMailer.send_mail_content(Operator::MailContent.job_params(kind: :login, obj: user)).deliver_later
          redirect_back_or account_root_path
        else
          flash.now[:error] = "Please activate your account by following the instructions in the account confirmation email you received to proceed"
          render action: :new
        end
      else
        flash.now[:error] = "Invalid UserID or Password!"
        render action: :new
      end
    else
      flash.now[:error] = "The data you entered for the CAPTCHA wasn't correct. Please try again"
      render action: :new
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to account_sign_in_path
  end
end
