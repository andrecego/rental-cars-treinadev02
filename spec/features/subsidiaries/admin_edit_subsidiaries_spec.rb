require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Coqueiro', cnpj: '00.000.000/0000-00', address: 'Rua que desce, 55')

    admin_login
    visit root_path
    click_on 'Filiais'
    click_on 'Editar'
    fill_in 'Nome', with: 'Bota Cars'
    fill_in 'CNPJ', with: '55.555.555/5555-55'
    fill_in 'Endereço', with: 'Rua da Sola, 78'
    click_on 'Enviar'

    expect(page).to have_content('Bota Cars')
    expect(page).to have_content('55.555.555/5555-55')
    expect(page).to have_content('Rua da Sola, 78')
    expect(page).to_not have_content('Coqueiro')
    expect(page).to_not have_content('00.000.000/0000-00')
    expect(page).to_not have_content('Rua que desce, 55')
  end

  scenario 'and isnt logged in' do
    visit new_manufacturer_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and isnt admin' do
    user_login
    visit new_manufacturer_path
    
    expect(page).to have_content('Você não tem essa permissão')
  end
end