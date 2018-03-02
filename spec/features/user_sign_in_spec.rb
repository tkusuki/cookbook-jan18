require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    # cria os dados necessários
    User.create(email: 'user@gmail.com', password: '12345')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'user@gmail.com'
    fill_in 'Senha', with: '12345'

    # expectativas do usuário após a ação
    expect(page).to have_css('nav', text: 'Bem-vindo user@gmail.com')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
  end
end
