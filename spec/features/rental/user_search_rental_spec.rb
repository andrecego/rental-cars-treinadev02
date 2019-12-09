require 'rails_helper'

feature 'User search rental' do
  scenario 'sucessfully' do
    client =Client.create!(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')
    category = CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')
    rental = Rental.create!(client: client, car_category: category, 
                            start_date: 1.day.from_now, end_date: 2.days.from_now,
                            reservation_code: 'ABC1234')
    other_rental = Rental.create!(client: client, car_category: category, 
                                  start_date: 1.day.from_now, end_date: 2.days.from_now,
                                  reservation_code: 'AAA1234')

    user_login
    visit root_path
    click_on 'Locação'
    fill_in 'Código', with: rental.reservation_code
    click_on 'Buscar'

    expect(page).to have_content(rental.reservation_code)
    expect(page).to_not have_content(other_rental.reservation_code)
  end
end