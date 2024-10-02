class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |resource|
      if resource.persisted?
        token = resource.generate_jwt
        render json: { message: 'Login bem-sucedido', token: token, user: resource }, status: :ok and return
      else
        render json: { error: 'Login falhou' }, status: :unauthorized and return
      end
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: { user: resource }, status: :created
  end
end
# frozen_string_literal: true

# class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
# end
