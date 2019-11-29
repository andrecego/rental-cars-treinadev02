require 'rails_helper'

feature 'Administrator view all categories' do
  scenario 'successfully' do
    CarCategory.create(name: 'B', 
                      daily_rate: '70.00', 
                      car_insurance: '500.00',
                      third_party_insurance: '200.00')
    CarCategory.create(name: 'A', 
                      daily_rate: '62.00', 
                      car_insurance: '323.22',
                      third_party_insurance: '99.99')

    visit root_path
    click_on 'Categorias'
    

    expect(page).to have_content('B')
    expect(page).to have_content('70.00')
    expect(page).to have_content('500.00')
    expect(page).to have_content('200.00')
    expect(page).to have_content('A')
    expect(page).to have_content('62.00')
    expect(page).to have_content('323.22')
    expect(page).to have_content('99.99')

    expect(page).to have_link('Voltar')
  end
end