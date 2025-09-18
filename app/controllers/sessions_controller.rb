class SessionsController < ApplicationController
  def new
  end

  def create
    # Allow login with either username or email
    user = User.find_by("username = :login OR email = :login", login: params[:login])
    
    if user&.authenticate(params[:password])
      if user.verified?
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in successfully!"
      else
        redirect_to login_path, alert: "Please verify your email address before logging in."
      end
    else
      flash.now[:alert] = "Invalid username/email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end