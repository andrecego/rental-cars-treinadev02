require 'rails_helper'

describe Rental do
  describe ".end_date_must_be_greather_than_start_date" do
    it "success" do
      client = Client.new(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')
      category = CarCategory.new(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')  
      rental = Rental.new(start_date: '09/12/2019', end_date: '10/12/2019', client: client, car_category: category)

      rental.valid?

      expect(rental.errors).to be_empty
    end
    
    it "end date less than start date" do
      rental = Rental.new(start_date: '09/12/2019', end_date: '08/12/2019')

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
  
end
