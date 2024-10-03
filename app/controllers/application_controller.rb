class ApplicationController < ActionController::Base
  # Codifica o payload em um JWT
  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end
  
  # Desativa a proteção CSRF apenas em ambiente de desenvolvimento
  protect_from_forgery unless: -> { Rails.env.development? }
  
  # Retorna o usuário atual com base no token JWT
  def current_user
    @current_user ||= User.find_by(id: decoded_token['user_id']) if decoded_token
  end

  # Decodifica o token JWT e retorna o payload
  def decoded_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ').last
      begin
        JWT.decode(token, 'secret', true, algorithm: 'HS256')[0] # Corrigido para 'HS256'
      rescue JWT::DecodeError
        nil
      end
    end
  end

  # Verifica se o usuário está autorizado
  def authorized_user
    decoded_token = decoded_token()
    if decoded_token
      user_id = decoded_token['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  # Requer que o usuário esteja logado para acessar certos endpoints
  def authorize
    render json: { error: 'Você precisa estar logado' }, status: :unauthorized unless authorized_user
  end

  # Tratamento de exceções de autorização com CanCan
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end
end
