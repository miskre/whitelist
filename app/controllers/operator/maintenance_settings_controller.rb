class Operator::MaintenanceSettingsController < Operator::BaseController
  def show
    @setting = Operator::MaintenanceSetting.first_or_create
  end

  def update
    @setting = Operator::MaintenanceSetting.first_or_create
    if @setting.update(setting_params)
      redirect_to operator_maintenance_setting_path, flash: { success: 'Settings are updated.' }
    else
      render :show
    end
  end

  private
  def setting_params
    params.require(:operator_maintenance_setting).permit(:enabled, :message)
  end
end
