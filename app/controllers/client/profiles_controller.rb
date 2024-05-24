class Client::ProfilesController < ApplicationController
  before_action :set_user

  def show; end

  def edit; end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    if @user.update(user_params)
      redirect_to client_profile_path, notice: 'User was successfully updated.'
    else
      render :edit, alert: 'Edit was unsuccessful.'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :phone, :password, :image)
  end
end
