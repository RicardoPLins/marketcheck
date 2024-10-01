require "application_system_test_case"

class SupermercadosTest < ApplicationSystemTestCase
  setup do
    @supermercado = supermercados(:one)
  end

  test "visiting the index" do
    visit supermercados_url
    assert_selector "h1", text: "Supermercados"
  end

  test "should create supermercado" do
    visit supermercados_url
    click_on "New supermercado"

    fill_in "Endereco", with: @supermercado.endereco
    fill_in "Horario de funcionamento", with: @supermercado.horario_de_funcionamento
    fill_in "Nome", with: @supermercado.nome
    click_on "Create Supermercado"

    assert_text "Supermercado was successfully created"
    click_on "Back"
  end

  test "should update Supermercado" do
    visit supermercado_url(@supermercado)
    click_on "Edit this supermercado", match: :first

    fill_in "Endereco", with: @supermercado.endereco
    fill_in "Horario de funcionamento", with: @supermercado.horario_de_funcionamento
    fill_in "Nome", with: @supermercado.nome
    click_on "Update Supermercado"

    assert_text "Supermercado was successfully updated"
    click_on "Back"
  end

  test "should destroy Supermercado" do
    visit supermercado_url(@supermercado)
    click_on "Destroy this supermercado", match: :first

    assert_text "Supermercado was successfully destroyed"
  end
end
