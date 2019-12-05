require 'rails_helper'

feature 'User register new rental' do
  scenario 'successfully' do
    Client.create!(name: 'José', document: '123.456.789-98', email: 'jose@email.com')
    Client.create!(name: 'Yan', document: '123.456.000-98', email: 'yan@email.com')
    CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')
    CarCategory.create!(name: 'C', daily_rate: '150', car_insurance: '80.1', third_party_insurance: '70')

    visit root_path
    click_on 'Locação'
    click_on 'Cadastrar nova locação'
    fill_in 'Ínicio', with: '2019'
    fill_in 'Final', with: '2020'
    select 'Yan', from: 'Cliente'
    select 'C', from: 'Categoria'

    expect(page).to have_content('Locação cadastrada com sucesso')
    expect(page).to have_content('Nome do cliente: Yan')
    expect(page).to have_content('Ínicio: 2019')
    expect(page).to have_content('Final: 2020')
    expect(page).to have_content('Categoria: C')
  end
end