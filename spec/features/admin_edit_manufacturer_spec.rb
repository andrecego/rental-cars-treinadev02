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
end