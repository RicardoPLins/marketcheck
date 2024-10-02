class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { Rails.env.development? || request.format.json? }

  # Autenticação de usuário
  before_action :authenticate_user!

  # Tratamento de exceções de acesso negado
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end
end
