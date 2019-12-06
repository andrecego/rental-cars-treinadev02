require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_link('Sair')
    expect(page).to_not have_link('Entrar')
  end

  scenario 'and log out' do
    user = User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'
    click_on 'Sair'

    expect(page).to have_content('Signed out successfully')
    expect(page).to have_link('Entrar')
    expect(page).to_not have_link('Sair')
  end
end