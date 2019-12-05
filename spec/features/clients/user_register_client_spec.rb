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

  scenario 'and must fill in all fields' do
    visit new_client_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Todos campos precisam ser preenchidos')
  end

  scenario 'CPF must be in a valid format' do
    visit new_client_path
    fill_in 'Nome', with: 'José'
    fill_in 'CPF', with: '123.456.789/00'
    fill_in 'Email', with: 'jose@cliente.com'
    click_on 'Enviar'

    expect(page).to have_content('CPF está no formato inválido')
  end

  scenario 'CPF must bu unique' do
    Client.create!(name: 'Carlos', document: '123.456.789-00', email: 'carlos@email.com')

    visit new_client_path
    fill_in 'Nome', with: 'José'
    fill_in 'CPF', with: '123.456.789-00'
    fill_in 'Email', with: 'jose@cliente.com'
    click_on 'Enviar'

    expect(page).to have_content('CPF já registrado')
  end
end