# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        render json: { message: 'Password reset instructions sent to your email.' }, status: :ok

      else
        render json: { message: 'Invalid password reset credentials' }, status: :unprocessable_entity
      end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    # super
    # debugger
    render json: { message: 'Password reset successfully.' }, status: :ok
  end

  # PUT /resource/password
  def update
    # debugger
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if resource_class.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_database_authentication
        sign_in(resource_name, resource)
        render json: { message: 'Password reset successfully.', user: resource }, status: :ok
      else
        set_flash_message!(:notice, :updated_not_active)
        render json: { message: 'Password reset successfully. Please activate your account', user: resource }, status: :ok
      end
      # respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      # respond_with resource
      render json: { message: 'Could not update password.' , errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end


  protected

  # def after_resetting_password_path_for(resource)
  #   # super(resource)
  #     render json: { message: 'Password reset successfully.' }, status: :ok
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
