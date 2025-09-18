class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to root_path, notice: "Please check your email to verify your account."
    else
      render :new
    end
  end
  
  def verify
    user = User.find_by(verification_token: params[:token])
    
    if user
      user.verify
      redirect_to login_path, notice: "Email verified successfully. You can now log in."
    else
      redirect_to root_path, alert: "Invalid verification token."
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end