require 'rails_helper'

feature 'Admin deleted subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Locars', cnpj: '00.123.456/0001-09', address: 'Avenida que sobe, 768')
    
    admin_login
    visit root_path
    click_on 'Filiais'
    click_on 'Deletar'
    
    expect(page).to have_content('Filial apagada com sucesso') 
    expect(page).to_not have_content('Locars')
    expect(page).to_not have_content('00.123.456/0001-09')
    expect(page).to_not have_content('Avenida que sobe, 768')
  end
  
  scenario 'and has cars attached to it' do
    honda = Manufacturer.create!(name: 'Honda')
    category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                   third_party_insurance: '30')
    model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                             car_category_id: category.id, manufacturer_id: honda.id)
    subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '00.123.456/0001-09', address: 'Rua do meio, 95')
    Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100000,
                subsidiary_id: subsidiary.id)
     
    admin_login
    visit root_path
    click_on 'Filiais'
    click_on 'Deletar'

    expect(page).to have_content('Algo deu errado')
    #expect(page).to have_content('Ainda tem carros nessa filial')
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