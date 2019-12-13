require 'rails_helper'

describe Rental do
  describe ".end_date_must_be_greather_than_start_date" do
    xit "success" do
      client = Client.create!(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')
      category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')  
      rental = Rental.create!(start_date: '09/12/2019', end_date: '10/12/2019', client: client, car_category: category)

      rental.valid?

      expect(rental.errors).to be_empty
    end
    
    xit "end date less than start date" do
      rental = Rental.create!(start_date: '09/12/2019', end_date: '08/12/2019')

      rental.valid?

      expect(rental.errors.full_messages).to include('End date deve ser maior que data de início')
    end
    
    xit 'end date equal to start date' do
      
    end
    xit 'start date must exist' do
      
    end
    xit 'end date must exist' do
      
    end
  end
  
  describe '.cars_available?' do
    it 'should be false if subsidiary has no cars' do
      honda = Manufacturer.create!(name: 'Honda')
      subsidiary = Subsidiary.create!(name: 'Tatuape', cnpj: '04.566.744/0001-09', address: 'Avenida Alcântra Machado, 4321')
      client = Client.create!(name: 'Yan', document: '354.308.060-00', email: 'yan@email.com')
      category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')  
      rental = Rental.create!(start_date: '09/12/2019', end_date: '10/12/2019', client: client, 
                          car_category: category, subsidiary_id: subsidiary.id)
      client = Client.create!(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')

      result = rental.cars_available?

      expect(result).to be false
    end

    xit 'should be true if subsidiary has cars' do
      honda = Manufacturer.create!(name: 'Honda')
      subsidiary = Subsidiary.create!(name: 'Tatuape', cnpj: '04.566.744/0001-09', address: 'Avenida Alcântra Machado, 4321')
      client = Client.create!(name: 'Yan', document: '354.308.060-01', email: 'yan@email.com')
      category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')  
      rental = Rental.create!(start_date: '09/12/2019', end_date: '10/12/2019', client: client, 
                          car_category: category, subsidiary_id: subsidiary.id)
      client = Client.create!(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')
      category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')
      model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                               car_category_id: category.id, manufacturer_id: honda.id)
      car = Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100001,
                        subsidiary_id: subsidiary.id, status: :available)

      result = rental.cars_available?

      expect(result).to be true
    end

    it 'should be false if subsidiary has no cars from rental category' do
      honda = Manufacturer.create!(name: 'Honda')
      subsidiary = Subsidiary.create!(name: 'Tatuape', cnpj: '04.566.744/0001-09', address: 'Avenida Alcântra Machado, 4321')
      client = Client.create!(name: 'Yan', document: '354.308.060-02', email: 'yan@email.com')
      category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')  
      other_category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')  
      rental = Rental.create!(start_date: '09/12/2019', end_date: '10/12/2019', client: client, 
                          car_category: other_category, subsidiary_id: subsidiary.id)
      client = Client.create!(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')
      category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')
      model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                               car_category_id: category.id, manufacturer_id: honda.id)
      car = Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100001,
                        subsidiary_id: subsidiary.id, status: :available)

      result = rental.cars_available?

      expect(result).to be false
    end

    it 'should be false if subsidiary has rentals available' do
      honda = Manufacturer.create!(name: 'Honda')
      subsidiary = Subsidiary.create!(name: 'Tatuape', cnpj: '04.566.744/0001-09', address: 'Avenida Alcântra Machado, 4321')
      client = Client.create!(name: 'Yan', document: '354.308.060-02', email: 'yan@email.com')
      category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')  
      other_category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')  
      scheduled_rental = Rental.create!(start_date: 1.day.from_now, end_date: 5.days.from_now, client: client, 
                                        car_category: other_category, subsidiary_id: subsidiary.id)
      rental = Rental.create!(start_date: 1.day.from_now, end_date: 3.days.from_now, client: client, 
                          car_category: other_category, subsidiary_id: subsidiary.id)
      client = Client.create!(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')
      category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')
      model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                               car_category_id: category.id, manufacturer_id: honda.id)
      car = Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100001,
                        subsidiary_id: subsidiary.id, status: :available)

      result = rental.cars_available?

      expect(result).to be false
    end
  end
end
