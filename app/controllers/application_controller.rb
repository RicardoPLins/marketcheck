class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { Rails.env.development? }

  # Permitir a ação de login
  before_action :authenticate_user!

   # Redirecionamento após login
   def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_dashboard_path  # Redireciona para o dashboard de admin
    else
      user_dashboard_path  # Redireciona para o dashboard de usuário comum
    end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end
end
