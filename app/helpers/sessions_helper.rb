module SessionsHelper
  def logged_in_as_admin?
    user_signed_in? && current_user.admin?
  end

  def current_user? user
    user == current_user
  end
end
