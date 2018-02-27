require 'rails_helper'

feature 'User edit cuisine' do
  scenario 'successfully' do

    cuisine = Cuisine.create(name: 'Jamaican')

    visit root_path
    click_on cuisine.name
    click_on 'Editar'

    fill_in 'Nome', with: 'Jamaicana'
    click_on 'Enviar'

    expect(page).to have_content('Jamaicana')

  end
end
