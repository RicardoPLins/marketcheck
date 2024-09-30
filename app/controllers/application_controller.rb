class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { Rails.env.development? }
  
  # Permitir a ação de login
  before_action :authenticate_user!, except: [:add] # Modifique 'create' se necessário

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end
end
