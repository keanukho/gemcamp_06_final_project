class Admin::SessionsController < Devise::SessionsController

  def create
    user = User.admin.find_by(email: params[:admin_user][:email])
    if user
      super
    else
      flash[:alert] = "Invalid email"
      redirect_to new_admin_user_session_path
    end
  end

  private

  def after_sign_in_path_for(resource)
    admin_root_path
  end
end