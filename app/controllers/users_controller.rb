class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path,
        notice: "Thank you for signing up #{@user.first_name}"
    else
      render :new
    end
  end

  private
  def user_params
    user_parameters = [:first_name, :last_name, :email,
            :password, :password_confirmation, :omniauth]
    user_parameters << :admin if current_user.is_admin?
    params.require(:user).permit(
      *user_parameters)
  end
end
