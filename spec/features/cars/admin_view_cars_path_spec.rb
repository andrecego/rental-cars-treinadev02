require 'rails_helper'

xfeature 'Admin view cars' do
  scenario 'successfully' do
    visit root_path
    click_on 'Carros'

    expect(page).to have_content('Cadastrar novo carro')
    expect(page).to have_content('Voltar')
  end

  scenario 'and view list of registered cars' do
    honda = Manufacturer.create!(name: 'Honda')
    category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                   third_party_insurance: '30')
    model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                             car_category_id: category.id, manufacturer_id: honda.id)
    subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '00.123.456/0001-09', address: 'Rua do meio, 95')
    Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100000,
                subsidiary_id: subsidiary.id)
    
    visit cars_path

    expect(page).to have_css('td', text: 'Fit')
    expect(page).to have_css('td', text: '2015')
    expect(page).to have_css('td', text: 'Azul')
    expect(page).to have_css('td', text: 'ABC-1234')
    expect(page).to have_css('td', text: 'Paulista')
    expect(page).to_not have_content('Nenhum modelo cadastrado')
  end

  scenario 'and dont have any registered models' do
    visit car_models_path

    expect(page).to have_content('Nenhum modelo cadastrado')
    expect(page).to_not have_css('table')
  end
end