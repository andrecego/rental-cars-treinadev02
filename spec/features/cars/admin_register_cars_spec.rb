require 'rails_helper'

feature 'Admin register new car' do
  scenario 'successfully' do
    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar novo carro'
    fill_in 'Placa', with: 'ABC-1234'
    fill_in 'Cor', with: 'Azul'
    select 'Fit', from: 'Modelo'
    fill_in '100000', with: 'Quilometragem'
    select 'Paulista', from: 'Filial'

    expect(page).to have_content('Carro cadastrado com sucesso')
    expect(page).to have_content('Placa: ABC-1234')
    expect(page).to have_content('Cor: Azul')
    expect(page).to have_content('Modelo: Fit')
    expect(page).to have_content('Quilometragem: 100000')
    expect(page).to have_content('Filial: Paulista')
  end
end