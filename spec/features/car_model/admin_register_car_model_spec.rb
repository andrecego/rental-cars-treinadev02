require 'rails_helper'

feature 'Admin register new car model' do
  scenario 'successfully' do
    admin_login
    Manufacturer.create!(name: 'Ford')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                        third_party_insurance: '30')
    CarCategory.create!(name: 'B', daily_rate: '150.5', car_insurance: '79.91',
                        third_party_insurance: '56.3')

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Cadastrar novo modelo'
    fill_in 'Nome', with: 'Fit'
    fill_in 'Ano', with: '2015'
    fill_in 'Motorização', with: '1.5'
    fill_in 'Combustível', with: 'Flex'
    select 'Honda', from: 'Fabricante'
    select 'A', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Fit')
    expect(page).to have_content('2015')
    expect(page).to have_content('1.5')
    expect(page).to have_content('Flex')
    expect(page).to have_content('Honda')
    expect(page).to have_content('A')
    expect(page).to have_content('Modelo de carro criado com sucesso')
  end

  scenario 'and isnt logged in' do
    visit new_car_model_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and isnt admin' do
    user_login
    visit new_car_model_path
    
    expect(page).to have_content('Você não tem essa permissão')
  end
end