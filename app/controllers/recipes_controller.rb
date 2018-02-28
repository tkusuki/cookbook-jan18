class RecipesController < ApplicationController
  def show
    id = params[:id]
    @recipe = Recipe.find_by(id: id)

    # if unless @recipe
    if @recipe.nil?
      flash[:error] = 'Não foi possível acessar essa receita'
      redirect_to root_path
    end
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create

    recipe_params = params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                                  :cook_time, :ingredients, :method,
                                                  :difficulty)

    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :new
    end
  end

  def edit
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    id = params[:id]
    @recipe = Recipe.find(id)
  end

  def update
    id = params[:id]
    @recipe = Recipe.find(id)

    recipe_params = params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                                  :cook_time, :ingredients, :method,
                                                  :difficulty)

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :edit
    end
  end

  def destroy
    id = params[:id]
    @recipe = Recipe.find(id)

    @recipe.destroy
    flash[:remove] = "Receita removida com sucesso"
    redirect_to root_path

  end


  private


end
