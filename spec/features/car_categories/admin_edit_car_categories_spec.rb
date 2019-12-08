require 'rails_helper'

feature 'Admin edit car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'AB', daily_rate: '20.33',
                        car_insurance: '50.36', third_party_insurance: '36.54')

    admin_login
    visit root_path
    click_on 'Categorias'
    click_on 'Editar'
    fill_in 'Categoria',	with: 'C'
    fill_in 'Diária',	with: '79.99'
    click_on 'Enviar'

    expect(page).to have_content('C') 
    expect(page).to have_content('79,99') 
    expect(page).to_not have_content('AB') 
    expect(page).to_not have_content('20,33') 
    expect(page).to have_content('Categoria atualizada com sucesso')
  end

  scenario 'and isnt logged in' do
    category = CarCategory.create!(name: 'AB', daily_rate: '20.33',
                                   car_insurance: '50.36', third_party_insurance: '36.54')

    visit edit_car_category_path(category)
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and isnt admin' do
    category = CarCategory.create!(name: 'AB', daily_rate: '20.33',
                                   car_insurance: '50.36', third_party_insurance: '36.54')

    user_login
    visit edit_car_category_path(category)
    
    expect(page).to have_content('Você não tem essa permissão')
  end
end