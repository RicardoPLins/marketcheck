class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # usuário não autenticado

    if user.admin?
      can :manage, :all # Administradores podem gerenciar tudo
    else
      can :read, Produto # Usuários normais podem apenas ler produtos
    end
  end
end
