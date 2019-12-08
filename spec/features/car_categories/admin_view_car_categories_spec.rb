require 'rails_helper'

feature 'Administrator view all categories' do
  scenario 'successfully' do
    CarCategory.create!(name: 'B', 
                        daily_rate: '70.00', 
                        car_insurance: '500.00',
                        third_party_insurance: '200.00')
    CarCategory.create!(name: 'A', 
                        daily_rate: '62.00', 
                        car_insurance: '323.22',
                        third_party_insurance: '99.99')

    admin_login
    visit root_path
    click_on 'Categorias'    

    expect(page).to have_content('B')
    expect(page).to have_content('70,00')
    expect(page).to have_content('500,00')
    expect(page).to have_content('200,00')
    expect(page).to have_content('A')
    expect(page).to have_content('62,00')
    expect(page).to have_content('323,22')
    expect(page).to have_content('99,99')

    expect(page).to have_link('Voltar')
  end

  scenario 'and didnt have a car_category' do
    admin_login
    visit car_categories_path

    expect(page).to have_content('Não existe nenhuma categoria de carro cadastrada')
    expect(page).to_not have_css('table') 
  end

  scenario 'and isnt logged in' do
    visit car_categories_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and isnt admin' do
    user_login
    visit car_categories_path

    expect(page).to have_content('Você não tem essa permissão')
  end
end