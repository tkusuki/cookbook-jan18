require 'rails_helper'

feature 'Visitor search for recipes' do
  scenario 'from home page' do
    # cria os dados necessários previamente
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Entrada')

    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    another_recipe = Recipe.create(title: 'Salada de cenoura', recipe_type: another_recipe_type,
                           cuisine: cuisine, difficulty: 'Facil',
                           cook_time: 60,
                           ingredients: 'Cenoura e legumes',
                           method: 'Cozinhe a cenoura, misture com os legumes')

    # simula a ação do usuário
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'
    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: 'Resultado da busca por: Bolo de cenoura')
    within("div.recipe_details") do
      expect(page).to have_css('h1', text: recipe.title)
      expect(page).to have_css('li', text: recipe.recipe_type.name)
      expect(page).to have_css('li', text: recipe.cuisine.name)
      expect(page).to have_css('li', text: recipe.difficulty)
      expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
      expect(page).not_to have_css('h1', text: another_recipe.title)
    end
  end

  scenario 'and navigate to recipe details' do
    # cria os dados necessários previamente
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'
    click_on 'Bolo de cenoura'

    # expectativas do usuário após a ação
    expect(current_path).to eq(recipe_path(recipe))
  end

  scenario 'and see all recipes' do
    # cria os dados necessários previamente
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    recipe_choco = Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 60,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path
    fill_in 'Busca', with: 'Bolo'
    click_on 'Buscar'

    # expectativas do usuário após a ação
    within("div#search_results") do
      expect(page).to have_css('h1', text: recipe.title)
      expect(page).to have_css('h1', text: recipe_choco.title)
      expect(page).to have_content('2 receitas encontradas')
    end
  end

  scenario 'and returns no results' do
    # cria os dados necessários previamente
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    another_cuisine = Cuisine.create(name: 'Japonesa')
    another_recipe_type = RecipeType.create(name: 'Entrada')
    another_recipe = Recipe.create(title: 'Temaki', recipe_type: another_recipe_type,
                           cuisine: another_cuisine, difficulty: 'Fácil',
                           cook_time: 40,
                           ingredients: 'Arroz, nori, salmão',
                           method: 'Cozinhe o arroz, adicione o arroz e o salmão picado no nori e enrole em formato de cone')

    # simula a ação do usuário
    visit root_path
    fill_in 'Busca', with: 'Feijoada'
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: 'Resultado da busca por: Feijoada')
    expect(page).to have_content('Nenhuma receita encontrada')
  end
end
