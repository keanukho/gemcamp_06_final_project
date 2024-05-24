class Admin::UserController < AdminController

  def index
    @users = User.page params[:page]
  end
end