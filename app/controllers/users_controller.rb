class UsersController < ApplicationController
    # Criar um novo usuário
    def create
      @user = User.new(user_params)
      
      if @user.save
        @token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: @token }, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Login de um usuário existente
    def login
      @user = User.find_by(email: user_params[:email])
  
      if @user && @user.authenticate(user_params[:password])
        @token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: @token }, status: :ok
      else
        render json: { error: 'Email ou senha inválidos' }, status: :unprocessable_entity
      end
    end
  
    private
  
    # Definir os parâmetros permitidos para criação de usuário e login
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end
  end
  