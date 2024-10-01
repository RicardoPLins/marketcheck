# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    # Sobrescreve o método create para retornar JSON em vez de redirecionar
    def create
      build_resource(sign_up_params)
  
      resource.save
      if resource.persisted?
        # Se o recurso foi salvo com sucesso
        if resource.active_for_authentication?
          token = resource.generate_jwt
          render json: { message: 'Registro bem-sucedido', token: token, user: resource }, status: :created
        else
          render json: { message: 'Registrado com sucesso, mas aguardando confirmação.' }, status: :ok
        end
      else
        render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def respond_with(resource, _opts = {})
      render json: { user: resource }, status: :created
    end
  end
  