# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  # Redirecionar para a página de login após o logout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path  # Redireciona para a página de login
  end
end
