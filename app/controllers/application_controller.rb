class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?
  before_action :load_categories
  before_action :search

  def load_categories
    @super_categories = Category.available.super
  end

  def search
    @search = Tour.search params[:q]
  end

  def store_current_location
    store_location_for(:user, request.fullpath) unless request.xhr?
  end

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_root_url : stored_location_for(resource)
  end

  private

  def configure_permitted_parameters
    add_attrs = [:name, :email, :address, :phone_number]
    devise_parameter_sanitizer.permit :sign_up, keys: add_attrs
    devise_parameter_sanitizer.permit :account_update, keys: add_attrs
  end
end
