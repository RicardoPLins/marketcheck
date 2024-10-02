class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "admin"
      can :manage, :all  # Administradores podem fazer qualquer coisa
    else
      can :manage, Carrinho
      can :add, Produto
      can :read, Produto  # Usuários comuns podem apenas ler a lista de produtos
      can :read, Supermercado  # Usuários comuns podem apenas ler a lista de supermercados
    end
  end
end
