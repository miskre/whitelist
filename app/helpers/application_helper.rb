module ApplicationHelper
  def local_time(time)
    time.in_time_zone('Tokyo').strftime('%Y/%m/%d %H:%M:%S')
  end

  def local_time_date_only(time)
    local_time(time)[0..11]
  end

  def local_time_timestamp_only(time)
    local_time(time)[11..-1]
  end

  def currency(account)
    case account.currency.code
    when "JPY"
      number_to_currency(account.balance, :format => "%u%n", :unit => "JPY ", :precision => 0)
    when "USD"
      number_to_currency(account.balance, :format => "%u%n", :unit => "USD ", :precision => 2)
    else
      account.balance.to_s(:delimited)
    end
  end

  def currencize_balance(number, code)
    case code
    when "JPY"
      number_to_currency(number, :format => "%n%u", :precision => 0)
    when "USD"
      number_to_currency(number, :format => "%u%n", :unit => "$ ", :precision => 2)
    else
      number.to_s(:delimited)
    end
  end

  def currencize_balance_explicit(number, code)
    u, b = number.to_s.split('.')
    case code
    when "JPY"
      number_to_currency(u, :format => "%n") + ".#{b} 円"
    when "USD"
      number_to_currency(u, :format => "%u%n", :unit => "$ ") + ".#{b}"
    else
      number.to_s(:delimited)
    end
  end

  def account_of_card(dc)
    case dc.card_type
    when "i-use"
      current_user.accounts.find_by(wallet_currency_id: Wallet::Currency.find_by_code("USD").id)
    when "FlowCard"
      current_user.accounts.find_by(wallet_currency_id: Wallet::Currency.find_by_code("GBP").id)
    end
  end

  def rate_usd_jpy
    real_rate = Wallet::Currency.find_by_code('JPY').rate
  end

  def currency_icon(account)
    case account.currency.code
    when "JPY"
      '<span class="fa fa-jpy m-r-xs"></span>&ensp;'
    when "USD"
      '<span class="fa fa-usd m-r-xs"></span>&ensp;'
    when "BTC"
      '<span class="fa fa-btc m-r-xs"></span>&ensp;'
    when "XRP"
      '<img src="/images/wallet/mark_xrp.png"> &ensp;'
    when "XID"
      '<img src="/images/wallet/xid.png"> &ensp;'
    end
  end

  def internal_transfer_fee
    set_view_of_fee(Wallet::TorihikiType::INTERNALTRANSFERFEE)
  end

  def oversea_remittance_fee
    set_view_of_fee(Wallet::TorihikiType::OVERSEAREMITTANCEFEE)
  end

  def card_charge_fee
    set_view_of_fee(Wallet::TorihikiType::CARDCHARGEFEE)
  end

  def incoming_funds_fiat_fee
    set_view_of_fee(Wallet::TorihikiType::INCOMINGFUNDSFIATFEE)
  end

  def deposit_information
    if current_user.agent.present? && File.exist?("#{Rails.root}/vendor/partners/current/deposit/_agent_id_is_#{current_user.agent.id}.html.slim")
      "agent_id_is_#{current_user.agent.id}"
    else
      "default"
    end
  end

  # 0時のログかを判断する
  def base_xep_log?(xep_log)
    xep_log.time.hour == 15
  end

  def qrcode_tag(text, options = {})
    ::RQRCode::QRCode.new(text).as_svg(options).html_safe
  end

  def get_xsystem_record_balance_by_logic(user, logic)
    xsystem_record_balance = XsystemRecord.where(wallet_user_id: user.id, logic_id: logic.id)
    if xsystem_record_balance.present?
      balance = xsystem_record_balance.last.balance.round(7)
      return balance
    else
      return 0
    end
  end

  def get_profit_xsystem_record(user, logic, daily)
    xsystem_records = logic.nil? ? XsystemRecord.where(wallet_user_id: user.id, summary: 2).where.not(logic_id: XsystemLogic.find_by_logic_name("BTC Address").id) : XsystemRecord.where(wallet_user_id: user.id, logic_id: logic.id, summary: 2)
    if daily == true
      xsystem_records_balance = xsystem_records.where("created_at >= ?", Time.zone.now.beginning_of_day).sum(:amount)
    else
      xsystem_records_balance = xsystem_records.where("created_at >= ?", Time.zone.now.beginning_of_month).sum(:amount)
    end
    xsystem_records_balance
  end

  def get_xsystem_request_locked(user, logic)
    request_locked = XsystemRequest.where(wallet_user_id: user.id, logic_id: logic.id, status: 4)
    if request_locked.present?
      amount = request_locked.last.amount.round(7)
      return amount
    else
      return 0
    end
  end

  def get_xsystem_request_pending(user, logic)
    if XsystemRequest.where(wallet_user_id: user.id, status: 3).present?
      status = 3
    else
      status = 0
    end
    request_pending = XsystemRequest.where(wallet_user_id: user.id, logic_id: logic.id, status: status)
    if request_pending.present?
      amount = request_pending.last.amount.round(7)
      return amount
    else
      return 0
    end
  end

  def get_xsystem_request_wallet_btc_account(user, logic)
    if XsystemRequest.where(wallet_user_id: user.id, status: 3).present?
      status = 3
    else
      status = 0
    end
    request_wallet_btc_account = XsystemRequest.where(wallet_user_id: user.id, logic_id: logic&.id, status: status)
    if request_wallet_btc_account.present?
      amount = request_wallet_btc_account.last.amount.round(7)
      return amount
    else
      return 0
    end
  end

  def get_xsystem_record_balance(user)
    xsystem_ids = XsystemRecord.where(wallet_user_id: user.id).group(:logic_id).maximum(:id).values
    XsystemRecord.where(id: xsystem_ids).sum(:balance)
  end

  private
    def set_view_of_fee(type)
      f = type.fee_config
      if f[:static]
        "$ #{f[:static]}"
      else
        "#{f[:percentage]}% (Min #{f[:min]} - Max #{f[:max]})"
      end
    end

end
