class SessionsController < ApplicationController
  def login
  end

  def create
    # User.find_by_email(params[:email])
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      # User has correct password
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back #{user.first_name}"
    else
      # User does not exist, or has invalid password
      flash[:alert] = 'Invalid email or password'
      render :login
    end
  end

  def destroy
    if user = current_user
      session.delete(:user_id)
      redirect_to root_path, notice: "#{user.email} has been logged out"
    end
  end
end
