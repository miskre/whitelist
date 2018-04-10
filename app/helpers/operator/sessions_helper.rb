module Operator::SessionsHelper
  def operator_begin_two_factor_auth(user)
    session[:operator_temporary_wallet_user_id] = user.id
  end

  def operator_while_two_factor_auth?
    session[:operator_temporary_wallet_user_id].present?
  end

  def operator_get_user_while_two_factor_auth
    Operator::User.find(session[:operator_temporary_wallet_user_id])
  end

  def operator_sign_in(user)
    session.delete(:operator_temporary_wallet_user_id)
    session[:operator_user_id] = user.id
  end

  def current_operator_user
    if session[:operator_user_id]
      @current_operator_user ||= Operator::User.find_by(id: session[:operator_user_id])
    end
  end

  def current_operator_user?(user)
    user == current_operator_user
  end

  def operator_signed_in?
    current_operator_user.present?
  end

  def operator_sign_out
    session.delete(:operator_user_id)
    @current_operator_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def enforce_operator_sign_in
    unless operator_signed_in?
      store_location
      flash[:error] = 'Please sign in.'
      redirect_to operator_sign_in_path
    end
  end

  def operator_permitted?
    case controller_name
    when 'home', 'history'
      unless current_operator_user.authority.value >= Operator::Authority::HOME_AND_HISTORY_ONLY.value
        redirect_to operator_root_path
      end
    else
      unless current_operator_user.authority == Operator::Authority::SHO
        redirect_to operator_root_path
      end
    end
  end
end
