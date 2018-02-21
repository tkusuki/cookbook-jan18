class RecipesController < ApplicationController
  def show
    id = params[:id]
    @recipe = Recipe.find(id)
  end

  def new
    @recipe = Recipe.new
  end

  def create

    recipe_params = params.require(:recipe).permit(:title, :recipe_type, :cuisine_id,
                                                  :cook_time, :ingredients, :method,
                                                  :difficulty)

    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      flash[:error] = "Você deve informar todos os dados da receita"
      render :new
    end
  end
end
