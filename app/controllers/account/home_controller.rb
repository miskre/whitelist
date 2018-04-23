module Account
  class HomeController < Account::BaseController
    before_action :set_kyc_paper
    def index
      @kyc_paper ||= current_user.build_kyc
    end

    def create_info
      @kyc_paper = current_user.build_kyc(kyc_paper_params)
      @kyc_paper.save_base_info = true
      if @kyc_paper.save(context: :for_user)
        redirect_to account_verify_path, flash: {success: 'successfully created.'}
      else
        render :index
      end
    end

    def update_info
      @kyc_paper.assign_attributes(kyc_paper_params)
      if @kyc_paper.changed.any? && @kyc_paper.type.present?
        @kyc_paper.status = "pending"
      end
      @kyc_paper.save_base_info = true
      if @kyc_paper.save(context: :for_user)
        redirect_to account_verify_path, flash: {success: 'successfully updated.'}
      else
        p @kyc_paper.errors&.full_messages
        render :index
      end
    end

    def verify
      unless @kyc_paper.present?
        redirect_to account_info_path, flash: {error: 'You need to enter whitelist info.'}
      end
    end

    def update_verify
      @kyc_paper = @kyc_paper.becomes!(verify_info_params[:type].constantize)
      @kyc_paper.assign_attributes(verify_info_params)
      if @kyc_paper.changed.any?
        @kyc_paper.status = "pending"
      end
      @kyc_paper.save_base_info = false
      if @kyc_paper.save(context: :for_user)
        redirect_to account_status_path, flash: {success: 'successfully created.'}
      else
        render :verify
      end
    end

    def status
      unless @kyc_paper.present?
        redirect_to account_info_path, flash: {error: 'You need to enter whitelist info.'}
      else
        if @kyc_paper.status == nil
          redirect_to account_verify_path, flash: {error: 'You need to enter verify info.'}
        end
      end
    end

    private

      def set_kyc_paper
        @kyc_paper = current_user.kyc
      end
      def kyc_paper_params
        params.require(:kyc).permit(
          :country,
          :full_name,
          :birth_date,
          :street,
          :street2,
          :region,
          :city,
          :amount_range,
          :btc_address
        )
      end
      def verify_info_params
        params.require(:kyc).permit(
          :type,
          :face_and_passport,
          :passport,
          :passport_number,
          :face_and_license,
          :license,
          :license_reverse,
          :license_number,
          :national_id_card,
          :national_id_card_reverse,
          :face_and_national_id_card,
          :national_id_card_number
        )
      end
  end
end
