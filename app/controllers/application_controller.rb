class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #include SessionsHelper

  before_action :load_categories

  def load_categories
    @super_categories = Category.available.super
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "alert.please_log_in"
    redirect_to login_url
  end
end
