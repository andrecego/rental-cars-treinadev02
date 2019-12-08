require 'rails_helper'

feature 'Administrator register new car category' do
  scenario 'successfully' do
    admin_login
    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar nova categoria'    
    fill_in 'Categoria', with: 'B'
    fill_in 'Diária', with: '70'
    fill_in 'Seguro do carro', with: '250.51'
    fill_in 'Seguro contra terceiros', with: '99.90'
    click_on 'Enviar'

    expect(page).to have_content('B')
    expect(page).to have_content('70,00')
    expect(page).to have_content('250,51')
    expect(page).to have_content('99,90')
    expect(page).to have_link('Voltar')
  end

  scenario 'and isnt logged in' do
    visit new_car_category_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and isnt admin' do
    user_login
    visit new_car_category_path
    
    expect(page).to have_content('Você não tem essa permissão')
  end
end