require 'rails_helper'

feature 'User start the rental' do
  scenario 'successfully' do
    honda = Manufacturer.create!(name: 'Honda')
    category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                   third_party_insurance: '30')
    category2 = CarCategory.create!(name: 'C', daily_rate: '150', car_insurance: '110',
                                    third_party_insurance: '60')
    model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                             car_category_id: category.id, manufacturer_id: honda.id)
    model2 = CarModel.create!(name: 'HRV', year: '2017', motorization: '2.0', fuel_type: 'flex',
                              car_category_id: category2.id, manufacturer_id: honda.id)
    model3 = CarModel.create!(name: 'City', year: '2017', motorization: '2.0', fuel_type: 'flex',
                              car_category_id: category.id, manufacturer_id: honda.id)
    subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '00.123.456/0001-09', address: 'Rua do meio, 95')
    car = Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100001,
                      subsidiary_id: subsidiary.id, status: :available)
    car2 = Car.create!(license_plate: 'ABC-1111', color: 'Prata', car_model_id: model3.id, mileage: 100001,
                      subsidiary_id: subsidiary.id, status: :unavailable)
    car3 = Car.create!(license_plate: 'ABC-1222', color: 'Vermelho', car_model_id: model2.id, mileage: 20321,
                       subsidiary_id: subsidiary.id, status: :available)
    client = Client.create!(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')
    rental = Rental.create!(client: client, car_category: category, 
                            start_date: 1.day.from_now, end_date: 2.days.from_now,
                            reservation_code: 'ABCDE321')

    user_login
    visit root_path
    click_on 'Locação'
    fill_in 'Código', with: 'ABCDE321'
    click_on 'Buscar'
    select 'Honda Fit', from: 'Modelo'
    click_on 'Confirmar'

    expect(page).to have_content('Locação efetivada com sucesso')
    expect(page).to have_content('Carro: Honda Fit')
    expect(page).to_not have_content('Carro: Honda HRV')
    expect(page).to_not have_content('Efetivar')
  end
end