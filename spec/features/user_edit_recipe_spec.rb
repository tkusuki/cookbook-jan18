require 'rails_helper'

feature 'User edit recipe' do
  scenario 'successfully' do
    # cria os dados necessários
    cuisine = Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Feijoada', difficulty: 'Dificil', cook_time: 120,
      ingredients: 'muitos', method: 'Microondas', recipe_type: recipe_type,
      cuisine: cuisine)

    # simula a ação do usuário
    visit root_path
    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: 'Macarrao'
    select 'Italiana', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Facil'
    fill_in 'Tempo de Preparo', with: 30
    fill_in 'Ingredientes', with: 'Pacote de Macarrao e tomate'
    fill_in 'Como Preparar', with: 'Coloca tudo na panela em fogo medio'
    click_on 'Enviar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: 'Macarrao')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Facil')
    expect(page).to have_css('p', text: 'Italiana')
    expect(page).to have_css('p', text: '30 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Pacote de Macarrao e tomate')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Coloca tudo na panela em fogo medio')
  end

  scenario 'and must fill in all fields' do
    # cria os dados necessários
    cuisine = Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Feijoada', difficulty: 'Dificil', cook_time: 120,
      ingredients: 'muitos', method: 'Microondas', recipe_type: recipe_type,
      cuisine: cuisine)

    # simula a ação do usuário
    visit root_path
    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    # expectativas do usuário após a ação
    expect(page).to have_content('Você deve informar todos os dados da receita')

  end
end
