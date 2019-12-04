require  'rails_helper'

feature 'Admin edit manufacturer' do 
  scenario 'successfully' do
  
    Manufacturer.create!(name: 'Ford')
    visit root_path
    click_on 'Fabricantes'
    click_on 'Ford'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to_not have_content('Ford') 
    expect(page).to have_content('Honda') 
  end

  scenario 'and there is no manufacturer' do

    visit manufacturers_path

    expect(page).to have_content('Não existem filiais cadastradas') 
  end

  scenario 'and must fill in all fields' do

    honda = Manufacturer.create!(name: 'Honda') 
    visit edit_manufacturer_path(honda)
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome precisa ser preenchido')
  end

  scenario 'and tried to fill in with the same name' do
    
    Manufacturer.create!(name: 'Honda')
    fiat = Manufacturer.create!(name: 'Fiat')

    visit edit_manufacturer_path(fiat)
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso') 
  end
end