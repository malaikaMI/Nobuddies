class SessionsController < ApplicationController
  
  def new
    redirect_to root_url if logged_in?
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      remember @user
      flash[:success] = "Logged in successfully!"
      redirect_to root_url
    else
      flash.now[:danger] = "Invalid email/password combination!"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
