# 本人確認情報の承認を強制するモジュール
module Wallet
  module AcceptedEnforcable
    extend ActiveSupport::Concern

    included do
      before_action :enforce_accepted, unless: "current_user.kyc_accepted?"
    end

    def enforce_accepted
      redirect_to wallet_mypage_change_profile_path, flash: {warning: t('helpers.messages.not_accepted')}
    end
  end
end
