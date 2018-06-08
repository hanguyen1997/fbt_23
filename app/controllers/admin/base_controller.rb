module Admin
  class BaseController < ApplicationController
    layout "admin/application"

    before_action :authenticate_admin

    private

    def authenticate_admin
      return if logged_in_as_admin?
      redirect_to new_user_session_path, alert: t("alert.permission_denied")
    end
  end
end
