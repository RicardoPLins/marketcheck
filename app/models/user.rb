class User < ApplicationRecord
  has_one :carrinho
  after_create :create_empty_cart
  enum role: { user: 0, admin: 1 }

  before_create :assign_role

  private 

  def create_empty_cart
    Carrinho.create(user_id: self.id)
  end

  # Atribui a role baseado no checkbox
  def assign_role
    self.role ||= :user # Define como user por padrão
    self.role = :admin if self.role == '1' # Se o checkbox foi marcado
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
