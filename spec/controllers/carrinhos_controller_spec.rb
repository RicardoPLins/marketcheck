require 'rails_helper'

RSpec.describe CarrinhosController, type: :controller do
  # Inclua os helpers do Devise
  include Devise::Test::ControllerHelpers

  # Simule um usuário logado
  let(:user) { FactoryBot.create(:user) } # Use FactoryBot para criar um usuário

  before do
    sign_in user # Simula o login do usuário
  end

  describe 'GET #index' do
    it 'retorna sucesso e renderiza a template index' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
  it 'cria um novo carrinho' do
    post :create
    expect(response).to have_http_status(:redirect)
    expect(Carrinho.last.user).to eq(user)
    end
  end
end
