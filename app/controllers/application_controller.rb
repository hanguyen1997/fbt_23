class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :load_categories

  def load_categories
    @super_categories = Category.available.super
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "alert.please_log_in"
    redirect_to login_url
  end

  def correct_user
    return if current_user? @user
    flash[:danger] = t "alert.permission_denied"
    redirect_to root_url
  end
end
