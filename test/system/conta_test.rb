require "application_system_test_case"

class ContaTest < ApplicationSystemTestCase
  setup do
    @contum = conta(:one)
  end

  test "visiting the index" do
    visit conta_url
    assert_selector "h1", text: "Conta"
  end

  test "creating a Contum" do
    visit conta_url
    click_on "New Contum"

    fill_in "Data abertura", with: @contum.data_abertura
    fill_in "Data encerramento", with: @contum.data_encerramento
    fill_in "Numero", with: @contum.numero
    fill_in "Saldo", with: @contum.saldo
    fill_in "Tipo", with: @contum.tipo
    click_on "Create Contum"

    assert_text "Contum was successfully created"
    click_on "Back"
  end

  test "updating a Contum" do
    visit conta_url
    click_on "Edit", match: :first

    fill_in "Data abertura", with: @contum.data_abertura
    fill_in "Data encerramento", with: @contum.data_encerramento
    fill_in "Numero", with: @contum.numero
    fill_in "Saldo", with: @contum.saldo
    fill_in "Tipo", with: @contum.tipo
    click_on "Update Contum"

    assert_text "Contum was successfully updated"
    click_on "Back"
  end

  test "destroying a Contum" do
    visit conta_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contum was successfully destroyed"
  end
end
