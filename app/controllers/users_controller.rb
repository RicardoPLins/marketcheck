class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    # Lista os produtos e supermercados para o usuário comum
    @produtos = Produto.all
    @supermercados = Supermercado.all
  end
end
