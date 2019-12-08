require 'rails_helper'

feature 'Administrator view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Paulista', 
                      cnpj: '03.518.732/0001-66', 
                      address: 'Avenida Paulista, 1234')
    Subsidiary.create!(name: 'Tatuape', 
                      cnpj: '04.566.744/0001-09', 
                      address: 'Avenida Alcântra Machado, 4321')

    admin_login
    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_content('Paulista')
    expect(page).to have_content('03.518.732/0001-66')
    expect(page).to have_content('Avenida Paulista, 1234')
    expect(page).to have_content('Tatuape')
    expect(page).to have_content('04.566.744/0001-09')
    expect(page).to have_content('Avenida Alcântra Machado, 4321')
    expect(page).to have_link('Voltar')
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