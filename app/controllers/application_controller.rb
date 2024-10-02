class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { Rails.env.development? }
  
  # Permitir a ação de login
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end
end
