require 'rails_helper'

feature 'User register new client' do
  scenario 'successfully' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'
    fill_in 'Nome', with: 'José'
    fill_in 'CPF', with: '123.456.789-00'
    fill_in 'Email', with: 'jose@cliente.com'
    click_on 'Enviar'

    expect(page).to have_content('José')
    expect(page).to have_content('123.456.789-00')
    expect(page).to have_content('jose@cliente.com')
    expect(page).to have_content('Cliente registrado com sucesso')
    expect(page).to have_link('Voltar')
  end
end