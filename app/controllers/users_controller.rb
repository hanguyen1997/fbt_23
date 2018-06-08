class UsersController < ApplicationController
  before_action :load_user
  before_action :logged_in_user
  before_action :correct_user

  def show; end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "alert.user_not_found"
    redirect_to root_url
  end
end
