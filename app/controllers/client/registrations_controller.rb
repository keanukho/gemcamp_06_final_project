class Client::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    cookies[:promoter] = params[:promoter] if params[:promoter].present?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.parent_id = User.find_by(email: cookies[:promoter])&.id if cookies[:promoter].present?

    if @user.save
      parent = User.find_by(email: cookies[:promoter])
      if parent
        parent.increment!(:children_members)
        cookies.delete(:promoter)
      end
      redirect_to client_root_path, notice: 'Registration successful!'
    else
      flash.now[:alert] = 'Registration failed'
      render :new
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
