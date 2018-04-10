class Operator::SessionsController < Operator::BaseController
  layout 'operator/layouts/empty'
  skip_before_action :enforce_operator_sign_in
  skip_before_action :operator_permitted?

  def new
  end

  def create
    user = Operator::User.find_by_nickname(params[:session][:nickname])
    if user && user.authenticate(params[:session][:password])
      if user.use_two_factor_auth
        operator_begin_two_factor_auth user
        redirect_to action: :otp
      else
        operator_sign_in user
        flash[:success] = 'Wellcome back !!'
        redirect_back_or operator_root_path
      end
    else
      flash.now[:error] = "Invalid UserID or password!"
      render action: :new
    end
  end

  def otp
  end
  
  def two_factor_auth
    if operator_while_two_factor_auth?
      user = operator_get_user_while_two_factor_auth
      if user.verify_otp(params[:session][:otp])
        operator_sign_in user
        flash[:success] = 'Wellcome back !!'
        redirect_back_or operator_root_path
      else
        flash.now[:error] = "Invalid One-time Password"
        render action: :otp
      end
    else
      flash.now[:error] = "First, You must login with your ID and Password"
      render action: :new
    end
  end

  def destroy
    operator_sign_out if operator_signed_in?
    redirect_to '/', success: "Signed out!"
  end
end
