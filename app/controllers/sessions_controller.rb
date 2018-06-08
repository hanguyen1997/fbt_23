class SessionsController < ApplicationController
  layout "login", only: :new

  def new
    redirect_to root_url if logged_in?
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t "alert.login_success", name: user.name
      check_admin user
    else
      flash[:danger] = t "alert.invalid_login"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = t "alert.logout_success"
    redirect_to root_url
  end

  private

  def check_admin user
    user.admin? ? redirect_to(admin_root_url) : redirect_back_or(root_url)
  end
end
