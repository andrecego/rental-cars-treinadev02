require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'
    fill_in 'Nome', with: 'Coqueiro Cars'
    fill_in 'CNPJ', with: '12.345.678/0001-09'
    fill_in 'Endereço', with: 'Rua dos Coqueiros, 08'
    click_on 'Enviar'

    expect(page).to have_content('Coqueiro Cars')
    expect(page).to have_content('12.345.678/0001-09')
    expect(page).to have_content('Rua dos Coqueiros, 08')
  end

  scenario 'and didnt fill cnpj' do
    visit new_subsidiary_path
    fill_in 'Nome', with: 'Coqueiro Cars'
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: 'Rua dos Coqueiros, 08'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ inválido') 
  end

  scenario 'and filled cnpj with the wrong format' do
    visit new_subsidiary_path
    fill_in 'Nome', with: 'Coqueiro Cars'
    fill_in 'CNPJ', with: '00.111.256/0001/09'
    fill_in 'Endereço', with: 'Rua dos Coqueiros, 08'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ inválido') 
  end

  scenario 'and tried to register the same subsidiary' do
    Subsidiary.create!(name: 'Coqueiro', cnpj: '00.000.000/0000-00', address: 'Rua que desce, 55')
    visit new_subsidiary_path
    fill_in 'Nome', with: 'Coqueiro Cars'
    fill_in 'CNPJ', with: '00.000.000/0000-00'
    fill_in 'Endereço', with: 'Rua dos Coqueiros, 08'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ já cadastrado') 
  end
end