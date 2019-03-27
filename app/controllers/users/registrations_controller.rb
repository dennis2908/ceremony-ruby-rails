# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    
    if resource.update(account_update_params)
      flash[:notice] = "Successfully updated account"
    else
      # raise account_update_params.inspect
      flash[:alert] = resource.errors.full_messages.to_sentence
    end
    # bypass_sign_in resource, scope: resource_name
    redirect_to edit_user_registration_path(resource)
  end

  # DELETE /resource
  def destroy
    resource.prayers.destroy_all
    resource.lead_groups.destroy_all
    resource.comments.destroy_all
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :bio, :church, :verse])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    if account_update_params[:password] == "" && account_update_params[:password] == account_update_params[:password_confirmation]
      devise_parameter_sanitizer.permit(:account_update) {|u|u.permit(:username, :name, :bio, :church, :verse)}
    else
      devise_parameter_sanitizer.permit(:account_update) {|u|u.permit(:username, :name, :bio, :church, :verse, :password, :password_confirmation, :current_password)}
    end
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    prayers_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
