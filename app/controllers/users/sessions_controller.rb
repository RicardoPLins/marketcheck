class Users::SessionsController < Devise::SessionsController
    respond_to :json
  
    def create
      super do |resource|
        if resource.persisted?
          # Gerar o token JWT
          token = resource.generate_jwt
  
          # Resposta de login bem-sucedido
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
  