require 'rails_helper'

feature 'Admin register new car' do
  scenario 'successfully' do
    honda = Manufacturer.create!(name: 'Honda')
    category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                   third_party_insurance: '30')
    CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                     car_category_id: category.id, manufacturer_id: honda.id)
    Subsidiary.create!(name: 'Paulista', cnpj: '00.123.456/0001-09', address: 'Rua do meio, 95')

    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar novo carro'
    fill_in 'Placa', with: 'ABC-1234'
    fill_in 'Cor', with: 'Azul'
    select 'Fit', from: 'Modelo'
    fill_in 'Quilometragem', with: '100000'
    select 'Paulista', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Carro cadastrado com sucesso')
    expect(page).to have_content('Placa: ABC-1234')
    expect(page).to have_content('Cor: Azul')
    expect(page).to have_content('Modelo: Fit')
    expect(page).to have_content('Quilometragem: 100000')
    expect(page).to have_content('Filial: Paulista')
  end

  scenario 'and must fill in all fields' do
    visit new_car_path
    fill_in 'Placa', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Todos os campos precisam ser preenchidos')
  end

  scenario 'and mileage cant be negative' do
    honda = Manufacturer.create!(name: 'Honda')
    category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                   third_party_insurance: '30')
    CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                     car_category_id: category.id, manufacturer_id: honda.id)
    Subsidiary.create!(name: 'Paulista', cnpj: '00.123.456/0001-09', address: 'Rua do meio, 95')

    visit new_car_path
    fill_in 'Placa', with: 'ABC-1234'
    fill_in 'Cor', with: 'Azul'
    select 'Fit', from: 'Modelo'
    fill_in 'Quilometragem', with: '-1'
    select 'Paulista', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Quilometragem deve ser positiva')
  end

  scenario 'and license plate is already registered' do
    honda = Manufacturer.create!(name: 'Honda')
    category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                   third_party_insurance: '30')
    model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                             car_category_id: category.id, manufacturer_id: honda.id)
    subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '00.123.456/0001-09', address: 'Rua do meio, 95')
    Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100000,
                subsidiary_id: subsidiary.id)

    visit new_car_path
    fill_in 'Placa', with: 'ABC-1234'
    fill_in 'Cor', with: 'Verde'
    select 'Fit', from: 'Modelo'
    fill_in 'Quilometragem', with: '1000'
    select 'Paulista', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Placa já cadastrada')
  end
end