module Account::SessionsHelper
  def begin_two_factor_auth(user)
    session[:begin_two_factor_auth] = Time.now
    session[:temporary_wallet_user_id] = user.id
  end

  def while_two_factor_auth?
    session[:begin_two_factor_auth].present? && session[:temporary_wallet_user_id] && session[:begin_two_factor_auth] >= Settings.two_factor_auth.interval.seconds.ago
  end

  def get_user_while_two_factor_auth
    ::User.find(session[:temporary_wallet_user_id])
  end

  def fixed_time_for_two_factor_auth
    gap = (session[:begin_two_factor_auth].to_i%Settings.two_factor_auth.interval).seconds
    Time.now - gap
  end

  def sign_in_with_two_factor_auth(user)
    session.delete(:begin_two_factor_auth)
    session.delete(:temporary_wallet_user_id)
    sign_in user
  end    

  def sign_in(user)
    session[:last_signed_in_at] = user.last_signed_in_at
    user.update_last_signed_in_at
    session[:wallet_user_id] = user.id
  end

  def last_signed_in_time
    session[:last_signed_in_at].present? ? session[:last_signed_in_at] : Time.zone.now
  end

  def current_user
    if session[:wallet_user_id]
      @current_user ||= ::User.find_by(id: session[:wallet_user_id])
    end
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:wallet_user_id)
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def enforce_sign_in
    if !signed_in?
      store_location
      flash[:error] = 'Please sign in.'
      redirect_to account_sign_in_path
    elsif !system_available?
      flash[:error] = 'The system is unavailable.'
      redirect_to account_sign_in_path
    end
  end

  def set_operated_at
    session[:operated_at] = Time.now
  end

  def auto_logout
    if current_user && session[:operated_at] && 30.minutes.ago >= session[:operated_at]
      sign_out

      redirect_to account_sign_in_path, flash: {error: 'Time-out error occurred. Please log in again.'}
    end
  end

  def maintenance
    @maintenance ||= Operator::MaintenanceSetting.first_or_create
  end

  def system_available?
    !maintenance.enabled
  end
end
