require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    cuisine = Cuisine.create(name: 'Japonesa')
    recipe_type = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(title: 'Salada', difficulty: 'Facil', cook_time: 10,
    ingredients: 'folhas e tomate', method: 'misturar tudo com sal', recipe_type: recipe_type,
    cuisine: cuisine)

    visit root_path
    click_on recipe.title
    click_on 'Remover'

    expect(page).to have_content('Receita removida com sucesso')
    expect(page).to have_current_path(root_path)
  end

  scenario 'and try to remove the same recipe again' do

    # cria os dados necessários
    cuisine = Cuisine.create(name: 'Japonesa')
    recipe_type = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(title: 'Salada', difficulty: 'Facil', cook_time: 10,
    ingredients: 'folhas e tomate', method: 'misturar tudo com sal', recipe_type: recipe_type,
    cuisine: cuisine)

    # ação do usuário
    visit root_path
    click_on recipe.title
    click_on 'Remover'
    visit recipe_path(recipe.id)

    # expectativas do usuário
    expect(page).to have_content('Não foi possível acessar essa receita')
    expect(page).to have_current_path(root_path)
  end
end
