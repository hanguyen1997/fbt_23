class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_categories

  def load_categories
    @super_categories = Category.available.super
  end

  private

  def configure_permitted_parameters
    add_attrs = [:name, :email, :address, :phone_number]
    devise_parameter_sanitizer.permit :sign_up, keys: add_attrs
    devise_parameter_sanitizer.permit :account_update, keys: add_attrs
  end
end
