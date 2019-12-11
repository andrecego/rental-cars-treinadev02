require 'rails_helper'

describe CarModel do
  describe '.free?' do
    it 'success' do
      honda = Manufacturer.create!(name: 'Honda')
      category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                    third_party_insurance: '30')
      model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                              car_category_id: category.id, manufacturer_id: honda.id)
      subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '00.123.456/0001-09', address: 'Rua do meio, 95')
      car1 = Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100000,
                        subsidiary_id: subsidiary.id, status: :available)
      car1 = Car.create!(license_plate: 'ABC-1224', color: 'Azul', car_model_id: model.id, mileage: 100000,
                        subsidiary_id: subsidiary.id, status: :unavailable)

      expect(model.free?).to eq true
    end

    it 'dont have any available car' do
      honda = Manufacturer.create!(name: 'Honda')
      category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                    third_party_insurance: '30')
      model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                              car_category_id: category.id, manufacturer_id: honda.id)
      subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '00.123.456/0001-09', address: 'Rua do meio, 95')
      car1 = Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model_id: model.id, mileage: 100000,
                        subsidiary_id: subsidiary.id, status: :unavailable)

      expect(model.free?).to eq false
    end
  end
end