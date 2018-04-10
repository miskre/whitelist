module I18nHelper
  extend ActiveSupport::Concern

  def t(key, options = {})
    options[:namespace] = "#{controller_path}_controller.#{action_name}"
    super
  end
end
