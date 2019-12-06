require 'rails_helper'

def login
  user = User.create!(email: 'test@test.com', password: '123456')
  login_as(user)
end

feature 'User register new client' do
  scenario 'successfully' do
    login
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
    login
    visit new_client_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Todos campos precisam ser preenchidos')
  end

  scenario 'CPF must be in a valid format' do
    login
    visit new_client_path
    fill_in 'Nome', with: 'José'
    fill_in 'CPF', with: '123.456.789/00'
    fill_in 'Email', with: 'jose@cliente.com'
    click_on 'Enviar'

    expect(page).to have_content('CPF está no formato inválido')
  end

  scenario 'CPF must be unique' do
    Client.create!(name: 'Carlos', document: '123.456.789-00', email: 'carlos@email.com')

    login
    visit new_client_path
    fill_in 'Nome', with: 'José'
    fill_in 'CPF', with: '123.456.789-00'
    fill_in 'Email', with: 'jose@cliente.com'
    click_on 'Enviar'

    expect(page).to have_content('CPF já registrado')
  end

  scenario 'and isnt authenticated' do
    visit new_client_path

    expect(page).to have_content('You need to sign in or sign up before continuing')
  end
end