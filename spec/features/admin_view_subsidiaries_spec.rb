require 'rails_helper'

feature 'Administrator view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create(name: 'Paulista', 
                      cnpj: '03.518.732/0001-66', 
                      address: 'Avenida Paulista, 1234')
    Subsidiary.create(name: 'Tatuape', 
                      cnpj: '04.566.744/0001-09', 
                      address: 'Avenida Alcântra Machado, 4321')

    visit root_path
    click_on 'Filiais'
    
    Subsidiary.all.each do |sub|
      expect(page).to have_content(sub.name)
      expect(page).to have_content(sub.cnpj)
      expect(page).to have_content(sub.address)
    end
    expect(page).to have_link('Voltar')
  end
end