class Operator::UsersController < Operator::BaseController
  before_action :set_operator_user, only: [:show, :edit, :update, :destroy]

  def index
    @operator_users = Operator::User.all
  end

  def show
  end

  def new
    @operator_user = Operator::User.new
  end

  def edit
  end

  def create
    @operator_user = Operator::User.new(operator_user_params)
    @operator_user.set_two_factor_auth_secret!
    if @operator_user.save
      redirect_to @operator_user, flash: {success: 'User was successfully created.'}
    else
      render :new
    end
  end

  def update
    if @operator_user.update(operator_user_params)
      redirect_to @operator_user, flash: {success: 'User was successfully updated.'}
    else
      render :edit
    end
  end

  def destroy
    @operator_user.destroy
    redirect_to operator_users_url, flash: {success: 'User was successfully destroyed.'}
  end

  private
    def set_operator_user
      @operator_user = Operator::User.find(params[:id])
    end

    def operator_user_params
      params.require(:operator_user).permit(:nickname, :password, :authority, :use_two_factor_auth)
    end
end
