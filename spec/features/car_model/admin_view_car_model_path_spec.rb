require 'rails_helper'

feature 'Admin view car models' do
  scenario 'successfully' do
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Cadastrar novo modelo')
    expect(page).to have_content('Voltar')
  end

  scenario 'and view list of registered models' do
    honda = Manufacturer.create!(name: 'Honda')
    category = CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '50',
                                   third_party_insurance: '30')
    model = CarModel.create!(name: 'Fit', year: '2015', motorization: '1.5', fuel_type: 'flex',
                             car_category_id: category.id, manufacturer_id: honda.id)

    visit car_models_path

    expect(page).to have_link('Fit')
    expect(page).to_not have_content('Nenhum modelo cadastrado')
  end

  scenario 'and dont have any registered models' do
    visit car_models_path

    expect(page).to have_content('Nenhum modelo cadastrado')
    expect(page).to_not have_css('ul')
  end
end