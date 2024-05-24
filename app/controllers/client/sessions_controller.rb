class Client::SessionsController < Devise::SessionsController

  def create
    super
  end

  private

  def check_client_role
    user = User.client.find_by(email: params[:user][:email])
    unless user
      flash[:alert] = "Invalid email"
      redirect_to new_user_session_path
    end
  end

  def after_sign_in_path_for(resource)
    client_root_path
  end
end