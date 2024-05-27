class Admin::HomeController < AdminController
  before_action :authenticate_admin_user!

  def index
    @users = User.where(role: :client).includes(:parent, :children).page(params[:page]).per(5)
  end
end