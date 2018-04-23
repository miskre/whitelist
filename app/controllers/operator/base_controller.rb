class Operator::BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'operator/layouts/application'

  include I18nHelper
  include NumberHelper
  include Operator::SessionsHelper
  before_action :enforce_operator_sign_in
  before_action :operator_permitted?
  before_action :set_locale

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
