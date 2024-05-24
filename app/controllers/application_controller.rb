class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :check_role

  private

  def check_role
    return unless current_user
    return if current_user&.client?
    flash[:alert] = "Invalid email"
    sign_out
    redirect_to client_root_path
  end
end