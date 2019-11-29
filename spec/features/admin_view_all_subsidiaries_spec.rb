require 'rails_helper'

feature 'Administrator view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Paulista', 
                      cnpj: '03.518.732/0001-66', 
                      address: 'Avenida Paulista, 1234')
    Subsidiary.create!(name: 'Tatuape', 
                      cnpj: '04.566.744/0001-09', 
                      address: 'Avenida Alcântra Machado, 4321')

    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_content('Paulista')
    expect(page).to have_content('03.518.732/0001-66')
    expect(page).to have_content('Avenida Paulista, 1234')
    expect(page).to have_content('Tatuape')
    expect(page).to have_content('04.566.744/0001-09')
    expect(page).to have_content('Avenida Alcântra Machado, 4321')
    expect(page).to have_link('Voltar')
  end
end