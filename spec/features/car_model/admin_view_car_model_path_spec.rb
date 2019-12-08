require 'rails_helper'

feature 'Admin view car models' do
  scenario 'successfully' do
    admin_login
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Cadastrar novo modelo')
    expect(page).to have_content('Voltar')
  end

  scenario 'and view list of registered models' do
    honda = Manufacturer.create!(name: 'Honda')
    category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                   third_party_insurance: '30')
    model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                             car_category_id: category.id, manufacturer_id: honda.id)

    admin_login
    visit car_models_path

    expect(page).to have_link('Fit')
    expect(page).to_not have_content('Nenhum modelo cadastrado')
  end

  scenario 'and dont have any registered models' do
    admin_login
    visit car_models_path

    expect(page).to have_content('Nenhum modelo cadastrado')
  end

  scenario 'and isnt logged in' do
    visit car_models_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and isnt admin' do
    user_login
    visit car_models_path
    
    expect(page).to have_content('Você não tem essa permissão')
  end
end