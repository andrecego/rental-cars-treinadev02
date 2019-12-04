require 'rails_helper'

feature 'Admin deleted subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Locars', cnpj: '00.123.456/0001-09', address: 'Avenida que sobe, 768')

    visit root_path
    click_on 'Filiais'
    click_on 'Deletar'

    expect(page).to_not have_content('Locars')
    expect(page).to_not have_content('00.123.456/0001-09')
    expect(page).to_not have_content('Avenida que sobe, 768')
    expect(page).to have_content('Filial apagada com sucesso') 
  end
end