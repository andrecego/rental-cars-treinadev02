require 'rails_helper'

feature 'Admin view manufacturers' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    admin_login
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    admin_login
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end