class Account::BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'account/layouts/application'

  include Account::SessionsHelper
  include NumberHelper
  before_action :enforce_sign_in
  before_action :auto_logout
  after_action :set_operated_at
  before_action :set_locale

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
