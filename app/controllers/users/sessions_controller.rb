# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # before_action :configure_sign_in_params, only: [:create]

  def create
    reset_session
    self.resource = warden.authenticate(auth_options)
    if resource.present?
      sign_in(resource_name, resource)
      render_success_response(resource)
    else
      render_failure_response
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    render json: { message: 'Logout successful.' }, status: :ok
        
  end

  private

  def render_success_response(resource)
    render json: {
      message: 'Logged in successfully!',
      user: resource
    }, status: :ok
  end

  def render_failure_response
    render json: {
      message: 'Invalid email or password.',
      error: 'Authentication failed.'
    }, status: :unauthorized
  end


  
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
