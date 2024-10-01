class User < ApplicationRecord
  has_one :carrinho
  after_create :create__empty_cart
  enum role: {user: 0, admin:1}

  
  validates :email, presence: true
  validates :password, presence:true
  validates :password_confirmation, presence:true


  private
  def create__empty_cart
    Carrinho.create(user_id: self.id)
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
