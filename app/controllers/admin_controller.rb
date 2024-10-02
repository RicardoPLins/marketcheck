class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin

  def dashboard
    # Aqui você pode listar produtos e supermercados, criar novos etc.
    @produtos = Produto.all
    @supermercados = Supermercado.all
  end

  private

  def check_if_admin
    redirect_to user_dashboard_path unless current_user.admin?
  end
end
