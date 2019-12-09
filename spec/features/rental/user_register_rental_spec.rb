require 'rails_helper'

feature 'User register new rental' do
  scenario 'successfully' do
    Client.create!(name: 'José', document: '859.912.720-93', email: 'jose@email.com')
    Client.create!(name: 'Yan', document: '354.308.060-13', email: 'yan@email.com')
    CarCategory.create!(name: 'A', daily_rate: '100.56', car_insurance: '26.56', third_party_insurance: '56.99')
    CarCategory.create!(name: 'C', daily_rate: '150', car_insurance: '80.1', third_party_insurance: '70')

    user_login
    visit root_path
    click_on 'Locação'
    click_on 'Cadastrar nova locação'
    fill_in 'Ínicio', with: '2019/12/12'
    fill_in 'Final', with: '2019/12/19'
    select 'Yan (354.308.060-13)', from: 'Cliente'
    select 'C', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Locação cadastrada com sucesso')
    expect(page).to have_content('Nome do cliente: Yan')
    expect(page).to have_content('Ínicio: 12/12/2019')
    expect(page).to have_content('Final: 19/12/2019')
    expect(page).to have_content('Categoria: C')
  end

  xscenario 'and must fill in all fields' do
    
  end

  xscenario 'and start date must be less than the end date' do
    
  end
end