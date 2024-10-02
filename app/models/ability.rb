class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "admin"
      can :manage, :all  # Administradores podem fazer qualquer coisa
    else
      can :manage, Carrinho
      can :manage, Produto
      cannot :create, Produto # Exclui a permissão de criar produtos
      cannot :update, Produto # Exclui a permissão de editar produtos
      cannot :destroy, Produto # Exclui a permissão de excluir produtos
      can :read, Supermercado  # Usuários comuns podem apenas ler a lista de supermercados
    end
  end
end
