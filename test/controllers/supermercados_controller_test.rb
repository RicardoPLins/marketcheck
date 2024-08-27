require "test_helper"

class SupermercadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supermercado = supermercados(:one)
  end

  test "should get index" do
    get supermercados_url
    assert_response :success
  end

  test "should get new" do
    get new_supermercado_url
    assert_response :success
  end

  test "should create supermercado" do
    assert_difference("Supermercado.count") do
      post supermercados_url, params: { supermercado: { endereco: @supermercado.endereco, horario_de_funcionamento: @supermercado.horario_de_funcionamento, nome: @supermercado.nome } }
    end

    assert_redirected_to supermercado_url(Supermercado.last)
  end

  test "should show supermercado" do
    get supermercado_url(@supermercado)
    assert_response :success
  end

  test "should get edit" do
    get edit_supermercado_url(@supermercado)
    assert_response :success
  end

  test "should update supermercado" do
    patch supermercado_url(@supermercado), params: { supermercado: { endereco: @supermercado.endereco, horario_de_funcionamento: @supermercado.horario_de_funcionamento, nome: @supermercado.nome } }
    assert_redirected_to supermercado_url(@supermercado)
  end

  test "should destroy supermercado" do
    assert_difference("Supermercado.count", -1) do
      delete supermercado_url(@supermercado)
    end

    assert_redirected_to supermercados_url
  end
end
