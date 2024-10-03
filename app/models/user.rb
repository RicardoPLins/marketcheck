class User < ApplicationRecord
  has_secure_password

  # require 'jwt'
  has_one :carrinho
  has_many :favoritos
  has_many :produtos_favoritos, through: :favoritos, source: :produto
  after_create :create_empty_cart
  enum role: { user: 0, admin: 1 }

  # Método para gerar JWT
  # def generate_jwt
  #   JWT.encode({ id: id, exp: 24.hours.from_now.to_i }, Rails.application.secrets.secret_key_base)
  # end

  private 

  # Método para criar um carrinho vazio após a criação do usuário
  def create_empty_cart
    Carrinho.create(user_id: self.id)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
end
