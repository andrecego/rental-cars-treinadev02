require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    admin_login
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'and must fill in all fields' do
    admin_login
    visit new_manufacturer_path
    click_on 'Enviar'

    expect(page).to have_content('Nome precisa ser preenchido')
  end

  scenario 'and tried to fill in with the same name' do
    Manufacturer.create!(name: 'Honda')

    admin_login
    visit new_manufacturer_path
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso') 
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